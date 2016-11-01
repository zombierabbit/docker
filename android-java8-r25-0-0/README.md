# android-java8

This docker is to build Android Gradle project with Java 8.

Contains:

* Android SDK: r25.0.0
* Build tools: 21.1.2, 22.0.1, 23.0.1, 23.0.2, 23.0.3, 24, 24.0.1, 24.0.2, 24.0.3, 25
* Android API: 21, 22, 23, 24, 25
* Support maven repository
* Google maven repository
* Arm emulator: v21
* Platform tools
* Created emulator image named: "Nexus 5x"

## Build image

```bash
docker build -t zombierabbit/android .
```
