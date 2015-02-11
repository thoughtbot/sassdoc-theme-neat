coffee = require "gulp-coffee"
gulp = require "gulp"
gutil = require "gulp-util"
prefix = require "gulp-autoprefixer"
sass = require "gulp-sass"
minifyCSS = require "gulp-minify-css"
minifyJS = require "gulp-uglify"

gulp.task "default", ["watch"]
gulp.task "build", ["sass", "coffee"]

gulp.task "watch", ->
  gulp.watch "./source/sass/*.scss", ["sass"]
  gulp.watch "./source/coffeescript/*.coffee", ["coffee"]

gulp.task "sass", ->
  gulp.src("./source/sass/*.scss")
    .pipe sass
      errLogToConsole: true
    .pipe prefix(["last 15 versions", "> 1%", "ie 9"], cascade: true)
    .pipe minifyCSS()
    .pipe gulp.dest("./assets/css")

gulp.task "coffee", ->
  gulp.src("./source/coffeescript/*.coffee")
    .pipe coffee bare: true
    .on "error", (error) -> gutil.log(error.message)
    .pipe minifyJS()
    .pipe gulp.dest("./assets/js")
