const path = require('path')

module.exports = {
  devServer: {
    disableHostCheck: true
  },
  configureWebpack: {
    resolve: {
      alias: {
        '@': path.resolve(__dirname, 'src'),
        '@assets': path.resolve(__dirname, 'src/assets'),
        '@store': path.resolve(__dirname, 'src/store'),
        '@components': path.resolve(__dirname, 'src/components'),
        '@lib': path.resolve(__dirname, 'src/lib'),
        '@api': path.resolve(__dirname, 'src/api'),
        '@router': path.resolve(__dirname, 'src/router'),
        '@plugins': path.resolve(__dirname, 'src/plugins'),
        '@views': path.resolve(__dirname, 'src/views')
      }
    }
  },
  pluginOptions: {
    webpackBundleAnalyzer: {
      // openAnalyzer: true,
      analyzerPort: 8889
    }
  }
}
