const webpack    = require('webpack');
const merge      = require('webpack-merge').smart;
const path       = require('path');
const baseConfig = require('./webpack.base.config');

module.exports = merge(baseConfig, {
  entry: path.join(__dirname, 'client/index.js'),

  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.optimize.UglifyJsPlugin({
        minimize:   true,
        compressor: { warnings: false },
    }),
  ],
});
