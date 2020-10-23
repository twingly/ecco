# Changelog

## [v0.8.0](https://github.com/twingly/ecco/tree/v0.8.0) (2020-10-23)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.7.0...v0.8.0)

**Implemented enhancements:**

- Drop MySQL 5.5 support [\#45](https://github.com/twingly/ecco/issues/45)
- Update Vagrant box to ubuntu/bionic64 [\#39](https://github.com/twingly/ecco/issues/39)

**Closed issues:**

- Update mysql-binlog-connector [\#18](https://github.com/twingly/ecco/issues/18)

**Merged pull requests:**

- Run tests on Travis CI against MySQL 5.6/5.7/8.0 [\#53](https://github.com/twingly/ecco/pull/53) ([Chrizpy](https://github.com/Chrizpy))
- Update JRuby to 9.2.13.0 [\#50](https://github.com/twingly/ecco/pull/50) ([Chrizpy](https://github.com/Chrizpy))
- Update mysql-binlog-connector-java to 0.21.0 [\#48](https://github.com/twingly/ecco/pull/48) ([walro](https://github.com/walro))
- Drop JRuby 9.1 support [\#47](https://github.com/twingly/ecco/pull/47) ([walro](https://github.com/walro))
- Drop offical support for MySQL 5.5 [\#46](https://github.com/twingly/ecco/pull/46) ([walro](https://github.com/walro))
- Bump rake version [\#44](https://github.com/twingly/ecco/pull/44) ([walro](https://github.com/walro))
- Update mysql-binlog-connector-java to 0.20.1 [\#43](https://github.com/twingly/ecco/pull/43) ([roback](https://github.com/roback))
- Run MySQL 5.6 in Docker on Travis CI [\#42](https://github.com/twingly/ecco/pull/42) ([walro](https://github.com/walro))
- Replace Vagrant with Docker \(Compose\) [\#40](https://github.com/twingly/ecco/pull/40) ([walro](https://github.com/walro))
- Update mysql-binlog-connector to 0.19.1 [\#38](https://github.com/twingly/ecco/pull/38) ([roback](https://github.com/roback))
- Use JRuby 9.2.7.0 on Travis CI [\#37](https://github.com/twingly/ecco/pull/37) ([roback](https://github.com/roback))
- Run Travis CI tests on 9.2.6.0 [\#36](https://github.com/twingly/ecco/pull/36) ([walro](https://github.com/walro))
- Update mysql-binlog-connector to 0.19.0 [\#35](https://github.com/twingly/ecco/pull/35) ([roback](https://github.com/roback))
- Update mysql-binlog-connector dependency to 0.18.0 [\#34](https://github.com/twingly/ecco/pull/34) ([walro](https://github.com/walro))
- Run latest JRuby on Travis and ensure we stick to bundler 1.x [\#33](https://github.com/twingly/ecco/pull/33) ([walro](https://github.com/walro))
- Test with latest version of JRuby 9.2.x [\#31](https://github.com/twingly/ecco/pull/31) ([walro](https://github.com/walro))
- Test with the latest rubies [\#30](https://github.com/twingly/ecco/pull/30) ([walro](https://github.com/walro))
- Accessor methods for connect\_timeout and heartbeat\_interval [\#28](https://github.com/twingly/ecco/pull/28) ([roback](https://github.com/roback))
- Update mysql-binlog-connector dependency to 0.16.1 [\#27](https://github.com/twingly/ecco/pull/27) ([walro](https://github.com/walro))

## [v0.7.0](https://github.com/twingly/ecco/tree/v0.7.0) (2016-10-07)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.6.1...v0.7.0)

**Implemented enhancements:**

- Extend on\_save\_position with information about the event [\#23](https://github.com/twingly/ecco/issues/23)

**Merged pull requests:**

- Expose event information in on\_save\_position [\#24](https://github.com/twingly/ecco/pull/24) ([dentarg](https://github.com/dentarg))
- Add changelog [\#21](https://github.com/twingly/ecco/pull/21) ([dentarg](https://github.com/dentarg))

## [v0.6.1](https://github.com/twingly/ecco/tree/v0.6.1) (2016-07-18)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.6.0...v0.6.1)

**Merged pull requests:**

- MySQL 5.6 support [\#20](https://github.com/twingly/ecco/pull/20) ([jage](https://github.com/jage))
- Use standard rvm key for jruby version [\#19](https://github.com/twingly/ecco/pull/19) ([walro](https://github.com/walro))
- Improve rake task description [\#17](https://github.com/twingly/ecco/pull/17) ([jage](https://github.com/jage))

## [v0.6.0](https://github.com/twingly/ecco/tree/v0.6.0) (2015-12-04)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.5.0...v0.6.0)

**Closed issues:**

- Feature: Ecco::Client\#connected? [\#14](https://github.com/twingly/ecco/issues/14)

**Merged pull requests:**

- Implement Ecco::Client\#connected? [\#15](https://github.com/twingly/ecco/pull/15) ([jage](https://github.com/jage))

## [v0.5.0](https://github.com/twingly/ecco/tree/v0.5.0) (2015-11-26)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.4.1...v0.5.0)

**Fixed bugs:**

- Trying to connect to non-existent position behaves strange? [\#8](https://github.com/twingly/ecco/issues/8)

**Merged pull requests:**

- Add keep alive getters and setters [\#11](https://github.com/twingly/ecco/pull/11) ([dentarg](https://github.com/dentarg))
- Helper method for java root logger [\#10](https://github.com/twingly/ecco/pull/10) ([dentarg](https://github.com/dentarg))
- Add \#on\_communication\_failure [\#9](https://github.com/twingly/ecco/pull/9) ([walro](https://github.com/walro))

## [v0.4.1](https://github.com/twingly/ecco/tree/v0.4.1) (2015-11-19)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.4.0...v0.4.1)

**Implemented enhancements:**

- Ensure that we handle "on\_row\_event" before "on\_save\_position" [\#5](https://github.com/twingly/ecco/issues/5)

**Merged pull requests:**

- Make sure row\_event happens before save\_event [\#7](https://github.com/twingly/ecco/pull/7) ([roback](https://github.com/roback))
- Minor refactoring [\#6](https://github.com/twingly/ecco/pull/6) ([dentarg](https://github.com/dentarg))

## [v0.4.0](https://github.com/twingly/ecco/tree/v0.4.0) (2015-11-18)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.3.1...v0.4.0)

**Implemented enhancements:**

- Integration tests [\#2](https://github.com/twingly/ecco/issues/2)

**Merged pull requests:**

- Add integration tests [\#3](https://github.com/twingly/ecco/pull/3) ([roback](https://github.com/roback))

## [v0.3.1](https://github.com/twingly/ecco/tree/v0.3.1) (2015-11-09)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.3.0...v0.3.1)

## [v0.3.0](https://github.com/twingly/ecco/tree/v0.3.0) (2015-11-09)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.2.0...v0.3.0)

**Merged pull requests:**

- Implement basic functionality [\#1](https://github.com/twingly/ecco/pull/1) ([walro](https://github.com/walro))

## [v0.2.0](https://github.com/twingly/ecco/tree/v0.2.0) (2015-10-27)

[Full Changelog](https://github.com/twingly/ecco/compare/v0.1.0...v0.2.0)

## [v0.1.0](https://github.com/twingly/ecco/tree/v0.1.0) (2015-10-27)

[Full Changelog](https://github.com/twingly/ecco/compare/2296b8e6dadf9b7c4daa6d8fbe08fc78de8f8fc4...v0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
