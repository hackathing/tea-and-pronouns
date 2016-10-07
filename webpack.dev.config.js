const merge      = require('webpack-merge').smart;
const path       = require('path');
const baseConfig = require('./webpack.base.config');

module.exports = merge(baseConfig, {
  entry: [
    'webpack-dev-server/client?http://localhost:8080',
    path.join(__dirname, 'client/index.js')
  ],

  devServer: {
    inline:   true,
    progress: true
  },
});
