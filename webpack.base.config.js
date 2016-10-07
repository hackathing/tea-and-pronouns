const path              = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const cssimport         = require('postcss-import');
const cssnext           = require('postcss-cssnext');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  output: {
    path:     path.resolve(__dirname, 'public/'),
    filename: 'main-[hash:5].js',
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: ['babel'],
      },
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      },
      {
        test: /\.(css)$/,
        loader: ExtractTextPlugin.extract('style-loader', [
          'css-loader',
          'postcss-loader',
        ]),
      },
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'client/index.html',
      inject:   'body',
      filename: 'index.html',
    }),
    new ExtractTextPlugin('./styles-[hash:5].css', { allChunks: true }),
  ],

  postcss: (webpack) => [
    cssimport({ path: "./client/styles/", addDependencyTo: webpack }),
    cssnext(),
  ],
};
