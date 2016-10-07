const path              = require('path');
const webpack           = require('webpack');
const merge             = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const cssimport         = require('postcss-import');
const cssnext           = require('postcss-cssnext');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const commonConfig = {
  output: {
    path:     path.resolve(__dirname, 'public/'),
    filename: '[hash].js',
  },

  module: {
    loaders: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      },
      {
        test: /\.(css)$/,
        loader: ExtractTextPlugin.extract('style-loader', [
          'css-loader',
          'postcss-loader',
        ])
      }
    ]
  },

  plugins: [
    new webpack.DefinePlugin({
      regexEndpoint: regexEndpoint,
    }),
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      inject:   'body',
      filename: 'index.html'
    }),
    new ExtractTextPlugin('./[hash].css', { allChunks: true }),
  ],

  postcss: (webpack) => [
    cssimport({ path: "./client/styles/", addDependencyTo: webpack }),
    cssnext(),
  ],
};

if (process.env.NODE_ENV === 'development') {
  console.log('Serving locally...');

  module.exports = merge(commonConfig, {

    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      path.join(__dirname, 'src/index.js')
    ],

    devServer: {
      inline:   true,
      progress: true
    },
  });
}

if (process.env.NODE_ENV === 'production') {
  console.log('Building for prod...');

  module.exports = merge(commonConfig, {

    entry: path.join(__dirname, 'src/index.js'),

    plugins: [
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.UglifyJsPlugin({
          minimize:   true,
          compressor: { warnings: false }
      })
    ]
  });
}
