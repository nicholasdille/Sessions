## Cloud Native Builds

### Where are we today?

XXX build prerequisites

XXX dependency on build agent

---

## Cloud Native Builds

### The future

```yaml
steps:

  - image: alpine/git
    commands:
      - git clone <somerepo>

  - image: openjdk:8-jdk
    commands:
      - javac HelloWorld.java
```

- Advantage 1
- Advantage 2
- Advantage 3

---

## Cloud Native Builds

### Existing solutions

- GitLab CI (docker executor)
- Drone CI
- Concourse CI
- Jenkins (Jenkinsfile DSL)

---

## Cloud Native Builds

### My solutions

XXX `insulatr`

--

## Demo: Cloud Native Builds

XXX call with `--allow-privileged`