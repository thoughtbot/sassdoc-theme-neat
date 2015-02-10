var extend = require("extend");
var extras = require("sassdoc-extras");
var swig = new require('swig');
var swigExtras = require("swig-extras");
var themeleon = require("themeleon")().use("consolidate");

swigExtras.useFilter(swig, "split");
swigExtras.useFilter(swig, "trim");
swigExtras.useFilter(swig, "groupby");

var theme = themeleon(__dirname, function (t) {
  t.copy("assets");
  t.swig('views/index.swig', 'index.html');
});

module.exports = function (dest, ctx) {
  var def = {
    display: {
      access: ["public", "private"],
      alias: false,
      watermark: true,
    },
    groups: {
      "undefined": "General",
    },
    "shortcutIcon": "http://sass-lang.com/favicon.ico"
  };

  ctx.view = extend(require("./view.json"), ctx.view);
  ctx.groups = extend(def.groups, ctx.groups);
  ctx.display = extend(def.display, ctx.display);
  ctx = extend({}, def, ctx);

  extras.markdown(ctx);
  extras.display(ctx);
  extras.groupName(ctx);

  ctx.data.byGroupAndType = extras.byGroupAndType(ctx.data);
  return theme.apply(this, arguments);
};
