#!/bin/bash
mkdir $1
cd $1
yarn init -y
git init
yarn add hardhat --dev
npx hardhat 

yarn add prettier prettier-plugin-solidity solhint eslint eslint-config-standard eslint-plugin-import eslint-plugin-mocha-no-only eslint-plugin-node eslint-plugin-promise eslint-plugin-standard --dev

echo '{
  "overrides": [
    {
      "files": "*.sol",
      "options": {
        "printWidth": 120,
        "tabWidth": 4,
        "useTabs": false,
        "singleQuote": false,
        "bracketSpacing": false,
        "explicitTypes": "always"
      }
    },
    {
      "files": "*.js",
      "options": {
        "tabWidth": 2,
        "useTabs": false,
        "semi": true,
        "singleQuote": true,
        "arrowParens": "always",
        "bracketSpacing": true
      }
    }
  ]
}
' >> .prettierrc

echo '
{
  "extends": ["standard", "plugin:promise/recommended"],
  "plugins": ["mocha-no-only", "promise"],
  "env": {
    "browser": true,
    "node": true,
    "mocha": true,
    "jest": true
  },
  "globals": {
    "artifacts": false,
    "contract": false,
    "assert": false,
    "web3": false,
    "usePlugin": false,
    "extendEnvironment": false
  },
  "rules": {
    // Strict mode
    "strict": ["error", "global"],

    // Code style
    "array-bracket-spacing": ["off"],
    "camelcase": ["error", { "properties": "always" }],
    "comma-dangle": ["error", "always-multiline"],
    "comma-spacing": ["error", { "before": false, "after": true }],
    "dot-notation": ["error", { "allowKeywords": true, "allowPattern": "" }],
    "eol-last": ["error", "always"],
    "eqeqeq": ["error", "smart"],
    "generator-star-spacing": ["error", "before"],
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "max-len": ["error", 120, 2],
    "no-debugger": "off",
    "no-dupe-args": "error",
    "no-dupe-keys": "error",
    "no-mixed-spaces-and-tabs": ["error", "smart-tabs"],
    "no-redeclare": ["error", { "builtinGlobals": true }],
    "no-trailing-spaces": ["error", { "skipBlankLines": false }],
    "no-undef": "error",
    "no-use-before-define": "off",
    "no-var": "error",
    "object-curly-spacing": ["error", "always"],
    "prefer-const": "error",
    "quotes": ["error", "single"],
    "semi": ["error", "always"],
    "space-before-function-paren": ["error", "always"],

    "mocha-no-only/mocha-no-only": ["error"],

    "promise/always-return": "off",
    "promise/avoid-new": "off"
  },
  "parserOptions": {
    "ecmaVersion": 2018
  }
}' >> .eslintrc


echo '
{
  "extends": "solhint:recommended",
  "rules": {
    "func-order": "off",
    "mark-callable-contracts": "off",
    "no-empty-blocks": "off",
    "compiler-version": "off",
    "private-vars-leading-underscore": "error",
    "reason-string": "off",
    "func-visibility": ["error", { "ignoreConstructors": true }]
  }
}' >> .solhint.json

echo '
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
insert_final_newline = true
trim_trailing_whitespace = false
max_line_length = 120

[*.sol]
indent_size = 4

[*.js]
indent_size = 2

[*.adoc]
max_line_length = 0' >> .editorconfig


yarn add @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-solhint --dev

echo '
require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-solhint')

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  solidity: '0.8.4',
}' > hardhat-config.js

mkdir contracts
mkdir test

echo '
node_modules

#Hardhat files
cache
artifacts

#VSCode files
.vscode' >> .gitignore


