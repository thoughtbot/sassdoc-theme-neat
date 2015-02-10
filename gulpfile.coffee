browserSync = require "browser-sync"
coffee = require "gulp-coffee"
gulp = require "gulp"
gutil = require "gulp-util"
prefix = require "gulp-autoprefixer"
sass = require "gulp-sass"

gulp.task "default", ["browser-sync", "watch"]
gulp.task "build", ["sass", "coffee"]

gulp.task "watch", ->
  gulp.watch "./source/sass/*.scss", ["sass"]
  gulp.watch "./source/coffeescript/*.coffee", ["coffee"]

gulp.task "sass", ->
  gulp.src("./source/sass/*.scss")
    .pipe sass
      errLogToConsole: true
    .pipe prefix(["last 15 versions", "> 1%", "ie 9"], cascade: true)
    .pipe gulp.dest("./assets/css")
    .pipe browserSync.reload(stream: true)

gulp.task "coffee", ->
  gulp.src("./source/coffeescript/*.coffee")
    .pipe coffee bare: true
    .on "error", (error) -> gutil.log(error.message)
    .pipe gulp.dest("./assets/js")
    .pipe browserSync.reload(stream: true)

gulp.task "browser-sync", ["sass", "coffee"], ->
  browserSync
    server:
      baseDir: "../neat-docs/docs/latest"
    host: "localhost"
    open: false
