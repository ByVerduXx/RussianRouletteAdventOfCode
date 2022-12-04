A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

## Running the code
### Instalation
To run this code you need to install dart and flutter. In linux I followed this process:
```bash
sudo apt-add-repository ppa:dartsim/ppa
sudo apt-get update

sudo reboot now

sudo apt-get install libdart6-all-dev
```

After that you need to install flutter and initialize it:
```bash
sudo snap install flutter --classic
flutter
```

### Running the code
To run the code you need to run the following command in the root of the project:
```bash
cat res/sample.in | dart run
```

Or input your intervals in the terminal:
```bash
> dart run
Building package executable... (1.9s)
Built day4:day4.
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
CTRL+D
The number of fully overlapped intervals is: 2
The number of partially overlapped intervals is: 4
```
