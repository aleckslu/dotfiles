/**
 *
 *
 */

// an example to create a new mapping `ctrl-y`
// mapkey('<Ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });

// mapkey('<ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });
//
// // an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// map('gt', 'T');
//
// // an example to remove mapkey `Ctrl-i`
// api.unmap('<ctrl-i>');
// REMOVING SOME DEFAULT KEYMAPS
// gdbewshy
// api.unmap('sg')

// default settings:
// https://github.com/brookhongoSurfingkeys?tab=readme-ov-file#properties-list

/** Keymaps */
settings.showModeStatus = true
settings.omnibarMaxResults = 20
settings.omnibarHistoryCacheSize = 200
settings.omnibarPosition = "top"
settings.omnibarSuggestion = true
settings.smoothScroll = false
settings.scrollStepSize = 100
settings.hintAlign = "left"
api.unmap("sd")
api.unmap("sb")
api.unmap("se")
api.unmap("sw")
api.unmap("ss")
api.unmap("sh")
api.unmap("sy")
api.unmap("q")
api.unmap("B")
api.unmap("F")
api.map("q", "x")
api.map("K", "E")
api.map("J", "R")
api.map("H", "S")
api.map("L", "D")
api.map("B", "b")
api.map("b", "T")
api.map("F", "af")
api.map("U", "X")
api.map("<", "<<")
api.map(">", ">>")

/** Styles */
api.Hints.style("font-size: 10pt;")

// // set theme
// settings.theme = `
// .sk_theme {
//     font-family: Input Sans Condensed, Charcoal, sans-serif;
//     font-size: 10pt;
//     background: #24272e;
//     color: #abb2bf;
// }
// .sk_theme tbody {
//     color: #fff;
// }
// .sk_theme input {
//     color: #d0d0d0;
// }
// .sk_theme .url {
//     color: #61afef;
// }
// .sk_theme .annotation {
//     color: #56b6c2;
// }
// .sk_theme .omnibar_highlight {
//     color: #528bff;
// }
// .sk_theme .omnibar_timestamp {
//     color: #e5c07b;
// }
// .sk_theme .omnibar_visitcount {
//     color: #98c379;
// }
// .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
//     background: #303030;
// }
// .sk_theme #sk_omnibarSearchResult ul li.focused {
//     background: #3e4452;
// }
// #sk_status, #sk_find {
//     font-size: 20pt;
// }`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
