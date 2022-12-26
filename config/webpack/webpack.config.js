const process = require('process');
const mode = process.env.NODE_ENV
console.log('Looks like we are in development (test) mode!');

const webpack = require('webpack')
const { webpackConfig, merge } = require('shakapacker')
const ForkTSCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')

const { basename, dirname, join, relative, resolve } = require('path')
const extname = require('path-complete-extname')
const { sync: globSync } = require('glob')

const Path = require('path')
const rootPath = Path.resolve(__dirname, '..', '..', '..')

const getEntryObject = () => {
  const entries = {}

  globSync(`${rootPath}/**/app/packs/entrypoints/**/*.*`).forEach((path) => {
    const namespace = relative(join(rootPath), dirname(path))
    const name = join(namespace, basename(path, extname(path)))
    let assetPaths = resolve(path)

    let previousPaths = entries[name]
    if (previousPaths) {
      previousPaths = Array.isArray(previousPaths) ?
        previousPaths : [previousPaths]
      previousPaths.push(assetPaths)
      assetPaths = previousPaths
    }

    const newName = name.replace(/^(?:\.\.\/)+/, "").replace(/.*app\/packs\/entrypoints\//, "")
    if (newName.startsWith(process.env.COMPONENT_NAME)) {
      entries[newName] = assetPaths
    }
  })

  return entries
}

const elmSource = Path.resolve(process.cwd())
const customConfig = {
  mode,
  plugins: [
    new ForkTSCheckerWebpackPlugin(),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(mode)
    })
  ],
  entry: getEntryObject(),
  resolve: {
    extensions: ['.elm', '.css']
  },
  module: {
    rules: [
      {
        test: /.(ts|tsx)$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: { loader: 'ts-loader' }
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
          options: { // https://github.com/rails/webpacker/blob/272762d670786cf4c7ee0e26b2f20ab12dfd37a9/lib/install/loaders/elm.js
            cwd: elmSource,
            pathToElm: `${elmSource}/node_modules/.bin/elm`,
            optimize: false,
            verbose: true,
            debug: true
          }
        }
      }
    ]
  },
  devServer: {
    allowedHosts: 'auto'
  }
}

module.exports = merge(webpackConfig, customConfig)
