# Vala

Vala cannot be compiled in Windows, so we need to instal WSL(linux subsystem for windows) and install Vala in it.
Once WSL installed:

```bash
sudo apt-get update
sudo apt-get install valac
```

For my code im using a package called Gee, so we need to install it too:

```bash
sudo apt-get install libgee-0.8-dev
```

Finally, to compile and execute the code we need to use the following command:

```bash
valac --pkg gee-0.8 day4.vala && ./day4
```
