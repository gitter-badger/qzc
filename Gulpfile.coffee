gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'test', ->
  gulp.src 'spec/**/*.coffee'
    .pipe mocha reporter: 'nyan'

gulp.task 'watch', ->
  gulp.watch ['spec/**/*.coffee', 'src/**/*.coffee'], ['test']

gulp.task 'default', ['test', 'watch'], ->
