var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    csslint = require('gulp-csslint'),
    cssmin = require('gulp-cssmin'),
    prefix = require('gulp-autoprefixer'),
    imagemin = require('gulp-imagemin'),
    pngcrush = require('imagemin-pngcrush'),
    rev = require('gulp-rev'),
    rename = require('gulp-rename'),
    rjs = require('gulp-requirejs'),
    bower = require('gulp-bower-files'),
    filter = require('gulp-filter'),
    uglify = require('gulp-uglify');

var paths = {
      images: [
        './app/assets/images/**/*',
        './lib/assets/images/**/*',
        './vendor/assets/images/**/*'
      ],
      javascripts: [
        './app/assets/javascripts/**/*.js',
        './lib/assets/javascripts/**/*.js',
        './vendor/assets/javascripts/**/*.js'
      ],
      stylesheets: [
        './app/assets/stylesheets/**/*.scss',
        './lib/assets/stylesheets/**/*.scss',
        './vendor/assets/stylesheets/**/*.scss'
      ]
    },
    options = {
      dest: './public/a',
      csslint: '.csslint',
      imagemin: {
        interlaced: true,
        progressive: true,
        use: [pngcrush()]
      },
      prefix: {
        cascade: true
      },
      rjs: {
        baseUrl: './public/a/javascripts',
        name: 'application',
        out: 'application.min.js',
        paths: {
          collapsable: 'modules/mas_collapsable',
          common: 'modules/common',
          cy: 'translations/cy',
          globals: 'modules/globals',
          i18n: 'modules/i18n',
          i18nTokens: 'translations/en',
          jquery: 'jquery/dist/jquery',
          log: 'modules/log',
          MASModule: 'lib/MASModule',
          MicroEvent: 'lib/MicroEvent',
          pubsub: 'modules/mas_pubsub',
          scrollTracking: 'modules/mas_scrollTracking',
          Toggler: 'components/Toggler',
          translations: 'translations/en',
          ujs: 'jquery-ujs/src/rails',
          waypoints: 'jquery-waypoints/waypoints'
        },
        shim: {
          'ujs': ['jquery']
        }
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

gulp.task('prep-javascripts', function() {
  'use strict';

  var dest = options.dest + '/javascripts';

  return gulp.src(paths.javascripts)
    .pipe(gulp.dest(dest))
    .pipe(bower())
    .pipe(filter('**/*.js', '!**/*.min.js'))
    .pipe(gulp.dest(dest));
});

gulp.task('javascripts', ['prep-javascripts'], function() {
  'use strict';

  var dest = options.dest + '/javascripts';

  return rjs(options.rjs)
    .pipe(uglify())
    .pipe(gulp.dest(dest));
});

gulp.task('stylesheets', function() {
  'use strict';

  var dest = options.dest + '/stylesheets';

  return gulp.src(paths.stylesheets)
    .pipe(sass(options.sass))
    .pipe(prefix(options.prefix))
    .pipe(csslint(options.csslint))
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
