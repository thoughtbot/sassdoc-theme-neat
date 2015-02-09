gulp = require "gulp"
sass = require "gulp-sass"
coffee = require "gulp-coffee"
prefix = require "gulp-autoprefixer"
gutil = require "gulp-util"

gulp.task "default", ["sass", "coffee"]

gulp.task "watch", ->
  gulp.watch "./source/sass/*.scss", ["sass"]
  gulp.watch "./source/coffeescript/*.coffee", ["coffee"]

gulp.task "sass", ->
  gulp.src("./source/sass/*.scss")
    .pipe sass
      errLogToConsole: true
    .pipe prefix(["last 15 versions", "> 1%", "ie 9"], cascade: true)
    .pipe gulp.dest("./assets/css")

gulp.task "coffee", ->
  gulp.src("./source/coffeescript/*.coffee")
    .pipe coffee bare: true
    .on "error", (error) -> gutil.log(error.message)
    .pipe gulp.dest("./assets/js")
