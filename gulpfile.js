var gulp = require('gulp'),
    sass = require('gulp-ruby-sass');

var paths = {
      stylesheets: [
        './app/assets/stylesheets/**/*.scss',
        './lib/assets/stylesheets/**/*.scss',
        './vendor/assets/stylesheets/**/*.scss'
      ]
    },
    options = {
      sass: {
        bundleExec: true,
        cacheLocation: './tmp/cache/sass',
        loadPath: './vendor/assets/bower_components',
        require: 'sass-globbing',
        style: 'compressed',
        unixNewlines: true
      }
    };

gulp.task('stylesheets', function() {
  'use strict';

  return gulp.src(paths.stylesheets)
    .pipe(sass(options.sass))
    .pipe(gulp.dest('./public/a'));
});

gulp.task('default', ['stylesheets']);
