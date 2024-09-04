/**
 *
 *
 */

// an example to create a new mapping `ctrl-y`
// api.mapkey('<ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });
//
// // an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// api.map('gt', 'T');
//
// // an example to remove mapkey `Ctrl-i`
// api.unmap('<ctrl-i>');
// REMOVING SOME DEFAULT KEYMAPS
// gdbewshy
// api.unmap('sg')

/** Keymaps */
settings.smoothScroll = false;
api.unmap("sd");
api.unmap("sb");
api.unmap("se");
api.unmap("sw");
api.unmap("ss");
api.unmap("sh");
api.unmap("sy");
api.unmap("q");
api.unmap("B");
api.unmap("F");
api.map("q", "x");
api.map("K", "E");
api.map("J", "R");
api.map("H", "S");
api.map("L", "D");
api.map("B", "b");
api.map("b", "T");
api.map("F", "af");
api.map("U", "X");
api.map("<", "<<");
api.map(">", ">>");

/** Styles */
api.Hints.style("font-size: 10pt;");
