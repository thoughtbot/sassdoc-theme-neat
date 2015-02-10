var themeleon = require("themeleon")().use("consolidate");
var extend = require("extend");
var extras = require("sassdoc-extras");

var theme = themeleon(__dirname, function (t) {
  t.copy("assets");

  var options = {
    partials: {},
  };

  t.handlebars("views/index.handlebars", "index.html", options);
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

  ctx.groups = extend(def.groups, ctx.groups);
  ctx.display = extend(def.display, ctx.display);
  ctx = extend({}, def, ctx);

  extras.markdown(ctx);
  extras.display(ctx);
  extras.groupName(ctx);

  ctx.data.byGroupAndType = extras.byGroupAndType(ctx.data);
  return theme.apply(this, arguments);
};
