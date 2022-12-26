const path = require("path");

const config = {
  verbose: true,
  roots: [
    "<rootDir>",
    path.resolve(`../components/${process.env.COMPONENT_NAME}`),
  ],
  setupFiles: ["<rootDir>/test-shim.js"],
  setupFilesAfterEnv: ["<rootDir>/jest-setup.js"],
  testEnvironment: "jsdom",
  testEnvironmentOptions: {
    url: "http://localhost",
  },
  modulePaths: [
    "<rootDir>",
    path.resolve(`../components/${process.env.COMPONENT_NAME}`),
  ],
  moduleDirectories: ["node_modules"],
  moduleFileExtensions: ["ts", "tsx", "js", "jsx"],
  preset: "ts-jest",
  transform: {
    "^.+\\.(ts|tsx)?$": "ts-jest",
    "^.+\\.(js|jsx)$": "babel-jest",
  },
  testMatch: [
    path.resolve(
      `../components/${process.env.COMPONENT_NAME}/test/**/*.test.js`
    ),
  ],
  clearMocks: true,
  collectCoverageFrom: [
    path.resolve(
      `../components/${process.env.COMPONENT_NAME}/app/packs/**/*.{js,jsx,ts,tsx}`
    ),
  ],
  coverageDirectory: "jest-coverage",
  testPathIgnorePatterns: ["\\\\node_modules\\\\"],
  transformIgnorePatterns: ["<rootDir>/node_modules/"],
};

module.exports = config;
