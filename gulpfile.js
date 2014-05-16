var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    prefix = require('gulp-autoprefixer'),
    imagemin = require('gulp-imagemin'),
    pngcrush = require('imagemin-pngcrush'),
    rev = require('gulp-rev'),
    rename = require('gulp-rename');

var paths = {
      images: [
        './app/assets/images/**/*',
        './lib/assets/images/**/*',
        './vendor/assets/images/**/*'
      ],
      stylesheets: [
        './app/assets/stylesheets/**/*.scss',
        './lib/assets/stylesheets/**/*.scss',
        './vendor/assets/stylesheets/**/*.scss'
      ]
    },
    options = {
      dest: './public/a',
      imagemin: {
        interlaced: true,
        progressive: true,
        use: [pngcrush()]
      },
      sass: {
        bundleExec: true,
        cacheLocation: './tmp/cache/sass',
        loadPath: './vendor/assets/bower_components',
        require: 'sass-globbing',
        style: 'compressed',
        unixNewlines: true
      }
    };

gulp.task('images', function() {
  'use strict';

  return gulp.src(paths.images)
    .pipe(imagemin(options.imagemin))
    .pipe(gulp.dest(options.dest))
    .pipe(rev())
    .pipe(gulp.dest(options.dest))
    .pipe(rev.manifest())
    .pipe(rename({ suffix: '-images' }))
    .pipe(gulp.dest(options.dest));
});

gulp.task('stylesheets', function() {
  'use strict';

  return gulp.src(paths.stylesheets)
    .pipe(sass(options.sass))
    .pipe(prefix())
    .pipe(rename({ extname: '' }))
    .pipe(gulp.dest(options.dest))
    .pipe(rev())
    .pipe(gulp.dest(options.dest))
    .pipe(rev.manifest())
    .pipe(rename({ suffix: '-stylesheets' }))
    .pipe(gulp.dest(options.dest));
});

gulp.task('default', ['images', 'stylesheets']);
