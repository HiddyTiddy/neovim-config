-- NeoVim Syntax File
-- Author: Hyde
-- Revision: 2023-01-13

-- print("loading after/syntax/markdown.lua")

if vim.fn.exists("g:no_vim_conceal") == 1 or not vim.fn.has("conceal") or vim.go.enc ~= "utf-8" then
    print("no fancy syntax, sorry")
    return
end

local function syntax_match_conceal(pattern, render_as, class)
    vim.cmd("syntax match " .. class .. ' "' .. pattern .. [[" conceal cchar=]] .. render_as)
end

local function syntax_match_latex(symb, render_as)
    -- \zsPATTERN\ze\(\>\|_\)
    syntax_match_conceal([[\zs\\\<]] .. symb .. [[\ze\(\>\|_\)]], render_as, "Operator")
end

vim.cmd([[syntax off]])

syntax_match_conceal("\\[\\ \\]", "", "todoCheckbox")
syntax_match_conceal("\\[x\\]", "", "todoCheckbox")
vim.cmd([[hi def link todoCheckbox Todo]])
vim.cmd([[hi Conceal guibg=NONE]])

local latexes = {
    ["in"] = "∈",
    notin = "∉",
    neq = "≠",
    int = "∫",
    contint = "∮",
    cup = "∪",
    cap = "∩",
    sum = "Σ",
    R = "ℝ",
    C = "ℂ",
    cdot = "·",
    infty = "∞",
    leq = "≤",
    geq = "≥",
    dots = "…",
    subset = "⊂",
    subseteq = "⊆",
    forall = "∀",
    exists = "∃",
    qed = "∎",
    nabla = "∇",
    sqrt = "√",
    del = "∂",
    leqgeq = "⋚",
    geqleq = "⋛",
}

local greek_alphabet = {
    tau = "τ",
    pi = "π",
    lambda = "λ",
    theta = "θ",
    alpha = "α",
    beta = "β",
    gamma = "γ",
    delta = "δ",
    eps = "ε",
    epsilon = "ε",
    zeta = "ζ",
    eta = "η",
    iota = "ι",
    kappa = "κ",
    mu = "μ",
    nu = "ν",
    xi = "ξ",
    omicron = "ο",
    rho = "ρ",
    sigma = "σ",
    upsilon = "υ",
    phi = "φ",
    varphi = "φ",
    chi = "χ",
    psi = "ψ",
    omega = "ω",
    -- upper
    Tau = "Τ",
    Pi = "Π",
    Lambda = "Λ",
    Theta = "Θ",
    Alpha = "Α",
    Beta = "Β",
    Gamma = "Γ",
    Delta = "Δ",
    Eps = "Ε",
    Epsilon = "Ε",
    Zeta = "Ζ",
    Eta = "Η",
    Iota = "Ι",
    Kappa = "Κ",
    Mu = "Μ",
    Nu = "Ν",
    Xi = "Ξ",
    Omicron = "Ο",
    Rho = "Ρ",
    Upsilon = "Υ",
    Phi = "Φ",
    Varphi = "Φ",
    Chi = "Χ",
    Sigma = "Σ",
    Psi = "Ψ",
    Omega = "Ω",
}

for pattern, value in pairs(greek_alphabet) do
    latexes[pattern] = value
end

for pattern, value in pairs(latexes) do
    syntax_match_latex(pattern, value)
end

local alt_script = {
    [0] = { "⁰", "₀" },
    [1] = { "¹", "₁" },
    [2] = { "²", "₂" },
    [3] = { "³", "₃" },
    [4] = { "⁴", "₄" },
    [5] = { "⁵", "₅" },
    [6] = { "⁶", "₆" },
    [7] = { "⁷", "₇" },
    [8] = { "⁸", "₈" },
    [9] = { "⁹", "₉" },
    a = { "ᵃ", "ₐ" },
    b = { "ᵇ", "" },
    c = { "ᶜ", "" },
    d = { "ᵈ", "" },
    e = { "ᵉ", "ₑ" },
    f = { "ᶠ", "" },
    g = { "ᵍ", "" },
    h = { "ʰ", "ₕ" },
    i = { "ⁱ", "ᵢ" },
    j = { "ʲ", "ⱼ" },
    k = { "ᵏ", "ₖ" },
    l = { "ˡ", "ₗ" },
    m = { "ᵐ", "ₘ" },
    n = { "ⁿ", "ₙ" },
    o = { "ᵒ", "ₒ" },
    p = { "ᵖ", "ₚ" },
    r = { "ʳ", "ᵣ" },
    s = { "ˢ", "ₛ" },
    t = { "ᵗ", "ₜ" },
    u = { "ᵘ", "ᵤ" },
    v = { "ᵛ", "ᵥ" },
    w = { "ʷ", "" },
    x = { "ˣ", "ₓ" },
    y = { "ʸ", "" },
    z = { "ᶻ", "" },
    -- TODO add more letters
}

vim.cmd([[
syn match important "IMPORTANT" | hi important ctermbg=red guibg=red
]])

for k, v in pairs(alt_script) do
    if v[1] ~= "" then
        syntax_match_conceal("\\^" .. k .. "\\>", v[1], "N")
    end
    if v[2] ~= "" then
        syntax_match_conceal("_" .. k .. "\\>", v[2], "N")
    end
end

vim.cmd([[setlocal conceallevel=1]])
