union
=====
##目标

本任务为高级别任务，并不打算直接开始。遵循小迭代的思路，先完成一些准备项目，积累相关开发经验和技术储备再开始。

##职业工会升级系统

任务等级： 高级<br/>
前提任务： 完成三个中级任务<br/>

工会维护系统，提供工会成员成长系统维护，深度集成githubapi。通过github commit和不同认证项目commit，得到项目经验和等级和勋章。

遵循磨级，刷怪，组团打BOSS的模式。工会系统，需要有track成员commit的功能，需要能够track成员完成项目的功能。同时生成成员成长报告。有定的经验可以做高级别的任务。任务（项目做的越多）越得到信任。

##可操作拆分

union将划分为不同等级小任务，反复练习重构后会重写到主union任务中来。<br/>
初步划分<br/>

- [x] github登录
- [x] 团队成员github commit，收集
- [ ] 根据commit数量和认证项目等级加权，得到经验等级
- [ ] 生成成员成长报告，
- [ ] 生成成员，总经验值排名
- [ ] 生成成员，成长值排名，月份，周，迭代周期排名

## 如何贡献

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. `cp config/database.yml.example config/database.yml`
4. `cp config/initializers/secret_token.rb.example config/initializers/secret_token.rb`
5. Commit your changes (git commit -am 'Add some feature')
6. Push to the branch (git push origin my-new-feature)
7. Create new Pull Request




