gulp = require 'gulp'
mocha = require 'gulp-mocha'
lint = require 'gulp-coffeelint'

gulp.task 'test', ->
  gulp.src 'spec/**/*.coffee'
    .pipe mocha reporter: 'nyan'

gulp.task 'lint', ->
  gulp.src ['spec/**/*.coffee', 'src/**/*.coffee']
    .pipe lint()
    .pipe lint.reporter()

gulp.task 'watch', ->
  gulp.watch ['spec/**/*.coffee', 'src/**/*.coffee'], ['test', 'lint']

gulp.task 'default', ['test', 'lint', 'watch'], ->
