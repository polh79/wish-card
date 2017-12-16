# Configuration
path =
  proxy: "wish.dev"
  server: './'
  css: './'
  scss: 'sass/'
  img: 'img/'


# Require
gulp = require('gulp')
browserSync = require('browser-sync')

$ = require('gulp-load-plugins')()

# Tasks
gulp.task 'sass', ->
  gulp.src "#{path.scss}*.scss"

  .pipe $.sass().on('error', $.sass.logError)

  .pipe $.autoprefixer
    browsers: ["ie >= 9", "ie_mob >= 10", "ff >= 30", "chrome >= 34", "safari >=7", "opera >= 23", "ios >= 7", "android >= 4.4", "bb >= 10"]

  .pipe gulp.dest path.css

  .pipe $.size()

  .pipe browserSync.reload(stream: true)

gulp.task 'default', ->
  opts =
    notify: false
    open: true
  if path['proxy']
    opts['proxy'] = path.proxy
  else
    opts['server'] = { baseDir: path.server }
  browserSync opts
  gulp.watch ['*.html'], browserSync.reload
  gulp.watch "#{path.scss}**/*.scss", ['sass']
