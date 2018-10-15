require('webpack');
const WebpackBar = require('webpackbar');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const processHTMLPages = require('./processHTMLHelper.js');
const PrettierPlugin = require("prettier-webpack-plugin");
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const extractCSS = new ExtractTextPlugin('../css/mfc.css');
const ProgressBar = new WebpackBar();
const plugins = [
  ProgressBar,
  extractCSS,
].concat(processHTMLPages());

module.exports = {
  entry: [
    "webpack-dev-server --mode=development",
    './source/index.js'
  ],
  module: {
    rules: [
      {
        test: [/\.scss$/i, /\.sass$/i, /\.css$/],
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader?-minimize',  'postcss-loader', 'sass-loader?outputStyle=uncompressed']
        })
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
        query: {
          name: '[path][name].[ext]',
          context: './source'
        }
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.es6'],
  },
  output: {
    path: __dirname + '/../views/js/',
    filename: 'mfc.js',
  },
  devServer: {
    contentBase: './source'
  },
  plugins
};
