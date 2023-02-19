use std::convert::Infallible;

use nvim_oxi::{self as oxi, Dictionary, Function, Object};
use oxi::api::{get_current_line, Window};

// s must be right after a '['
fn extract_link(s: &str) -> Option<(usize, &str)> {
    let (link_text, r) = s.split_once(']')?;
    if link_text.contains('[') {
        return None;
    }
    if !r.starts_with('(') {
        return None;
    }
    let r = &r['('.len_utf8()..];
    let (link, _) = r.split_once(')')?;

    Some((
        link_text.len() + '['.len_utf8() + '('.len_utf8() + ')'.len_utf8(),
        link,
    ))
}

fn md_link(cur_line: &str, curs_x: usize) -> Option<&str> {
    let mut cur_idx = 0;
    const LEN_BRK: usize = '['.len_utf8();
    for part in cur_line.split('[') {
        cur_idx += part.len() + LEN_BRK;
        if cur_idx > curs_x + 1 || cur_idx >= cur_line.len() {
            return None;
        };
        if let Some((rest_len, link)) = extract_link(&cur_line[cur_idx..]) {
            if curs_x < cur_idx + link.len() + rest_len {
                return Some(link);
            }
        }
    }

    None
}

fn md_link_around_cursor(_: ()) -> oxi::Result<Option<String>> {
    let (_, curs_x) = Window::current().get_cursor()?;
    let cur_line = get_current_line()?;

    Ok(md_link(&cur_line, curs_x).map(|x| x.to_owned()))
}

macro_rules! objectify_fn {
    ($funcname:ident) => {
        (
            stringify!($funcname),
            ::nvim_oxi::Object::from(::nvim_oxi::Function::from_fn($funcname)),
        )
    };
}

#[oxi::module]
fn hydutils() -> oxi::Result<Dictionary> {
    let add = Function::from_fn(|(a, b): (i32, i32)| Ok::<_, Infallible>(a + b));

    Ok(Dictionary::from_iter([
        ("add", Object::from(add)),
        objectify_fn!(md_link_around_cursor),
    ]))
}

#[cfg(test)]
mod tests {
    mod md_links {
        use crate::md_link;

        #[test]
        fn test_md_links() {
            let cur_line = "    [[[[[  [text](link) [[[]]]]]";

            assert_eq!(md_link(cur_line, 0), None);
            assert_eq!(md_link(cur_line, 4), None);
            assert_eq!(md_link(cur_line, 11), Some("link"));
            assert_eq!(md_link(cur_line, 12), Some("link"));
            assert_eq!(md_link(cur_line, 16), Some("link"));
            assert_eq!(md_link(cur_line, 17), Some("link"));
            assert_eq!(md_link(cur_line, 20), Some("link"));
            assert_eq!(md_link(cur_line, 22), Some("link"));
            assert_eq!(md_link(cur_line, 23), None);
            assert_eq!(md_link(cur_line, 28), None);
        }

        #[test]
        fn with_weird_link() {
            let cur_line = "[text](li[n]k)";
            assert_eq!(md_link(cur_line, 2), Some("li[n]k"));
        }

        #[test]
        fn with_spaces_in_text() {
            let cur_line = "[text with spaces](https://rust-lang.org)";
            assert_eq!(md_link(cur_line, 2), Some("https://rust-lang.org"));
        }

        #[test]
        fn select_right_link() {
            let cur_line = "[first link](the link number one)[second link](other link)";

            assert_eq!(md_link(cur_line, 0), Some("the link number one"));
            assert_eq!(md_link(cur_line, 15), Some("the link number one"));
            assert_eq!(md_link(cur_line, 32), Some("the link number one"));
            assert_eq!(md_link(cur_line, 33), Some("other link"));
            assert_eq!(md_link(cur_line, 38), Some("other link"));
            assert_eq!(md_link(cur_line, 57), Some("other link"));
        }

        #[test]
        fn handle_oob() {
            let cur_line = "[too](short)";

            assert_eq!(md_link(cur_line, 3), Some("short"));
            assert_eq!(md_link(cur_line, cur_line.len()), None);
            assert_eq!(md_link(cur_line, 120), None);
        }
    }
}
