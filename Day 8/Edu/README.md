# Day 8 in Purescript

## Setup

This is a node project:

```bash
npm init
```

Purescript and Spago have been installed in this local project:

```bash
npm install purescript spago
```

The following lines have been added to the `package.json`:

```json
{
  // ...
  "scripts": {
    "init": "spago init",
    "build": "spago build",
    "test": "spago run"
  },
  // ...
}
```

With these we can perform the following operations:

```bash
npm run init  # Create PureScript project
npm run build # Compile code
npm start     # Run & compile code
```

## Build

As previously mentioned just run:

```bash
npm run build
```

## Run

Once again, as we've said before you only need to run:

```bash
npm start < sample.in
```
