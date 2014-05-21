var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    cssmin = require('gulp-cssmin'),
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
        style: 'expanded',
        unixNewlines: true
      }
    };

gulp.task('images', function() {
  'use strict';

  var dest = options.dest + '/images';

  return gulp.src(paths.images)
    .pipe(imagemin(options.imagemin))
    .pipe(gulp.dest(dest))
    .pipe(rev())
    .pipe(gulp.dest(dest))
    .pipe(rev.manifest())
    .pipe(gulp.dest(dest));
});

gulp.task('stylesheets', function() {
  'use strict';

  var dest = options.dest + '/stylesheets';

  return gulp.src(paths.stylesheets)
    .pipe(sass(options.sass))
    .pipe(prefix())
    .pipe(rename({ extname: '' }))
    .pipe(gulp.dest(dest))
    .pipe(cssmin())
    .pipe(rename({ suffix: '.min' }))
    .pipe(gulp.dest(dest))
    .pipe(rev())
    .pipe(gulp.dest(dest))
    .pipe(rev.manifest())
    .pipe(gulp.dest(dest));
});

gulp.task('default', ['images', 'stylesheets']);
