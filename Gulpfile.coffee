gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'test', ->
  gulp.src 'spec/**/*.coffee'
    .pipe mocha reporter: 'nyan'

gulp.task 'default', ['test'], ->
