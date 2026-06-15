# 📚 机械设计手册 — 可检索知识库

> 《机械设计手册》第六版（成大先 主编，化学工业出版社）的数字知识库。不用翻书，直接搜。

---

## 🌐 在线体验

不需要部署，浏览器直接打开：

**https://nasplycc.github.io/mechanical-design-handbook/**

搜关键词、看结果、跳转到对应详细说明。跟翻纸质手册的体验完全不同。

---

## 📖 这是什么

《机械设计手册》第六版，5 卷本，8512 页，26 斤。搞机械的基本人手一套，但翻起来是真的累。

这个项目把整本手册做成了可检索的知识库。

有三个使用方式：

**1. 在线搜索（GitHub Pages）**
浏览器打开就能用，纯前端检索，不需要装任何东西。搜一个参数名，直接出结果。

**2. 本地 Web 界面**
跑在你自己机器上，功能更完整——支持公式渲染、PDF 一键跳转、设计向导。

**3. AI 机械设计助手（Skill）**
通过 [lineage-skill](https://github.com/JuneYaooo/lineage-skill) 蒸馏出的 AI Agent Skill，可直接对话查询机械设计知识，支持参数查询、选型计算、公式推导等。

---

## 🚀 本地启动

```bash
# Web 界面
bash run.sh web
# → http://localhost:5231

# 设计向导（输入需求，自动出报告）
bash run.sh design "齿轮齿条 10000N 3m"

# CLI 搜索
bash run.sh cli "45号钢调质硬度"

# MCP 服务（接入 AI 工具链）
bash run.sh mcp
```

---

## 🐳 Docker 部署

```bash
# 构建并启动
docker compose up -d --build

# 访问
# → http://localhost:5231

# 查看日志
docker logs -f mechanical-design-handbook

# 停止
docker compose down
```

---

## 🤖 AI 机械设计助手

本项目包含一个通过 [lineage-skill](https://github.com/JuneYaooo/lineage-skill) 蒸馏的 AI Skill：`mechanical-design-assistant`。

### 什么是 Skill？

Skill 是 AI Agent 的可复用知识模块。`mechanical-design-assistant` 将《机械设计手册》5卷8512页的内容蒸馏成结构化的知识体系，让 AI 能够：

- **精确查询参数** — 如"6214轴承的额定动载荷是多少？"
- **选型计算** — 如"根据1000r/min、10kN载荷选轴承"
- **公式推导** — 如"齿轮弯曲强度校核公式是什么？"
- **材料选择** — 如"45号钢调质后的硬度和强度？"
- **标准对照** — 如"IT7配合面的粗糙度推荐？"

### Skill 包含什么？

```
mechanical-design-assistant/
├── SKILL.md                    ← Skill 定义和使用规则
├── references/
│   ├── course_digest.md        ← 课程蒸馏笔记（135KB）
│   │   ├── 课程体系图
│   │   ├── 逐课精要（52课）
│   │   ├── 跨课程主题图谱
│   │   └── 关键概念词汇表
│   ├── full_transcript.md      ← 完整知识库文本（2.1MB）
│   ├── concept_glossary.md     ← 核心概念定义
│   ├── quote_index.md          ← 重要公式/规范金句
│   ├── study_paths.md          ← 学习路径/行动清单
│   ├── lesson_index.json       ← 52课时索引
│   ├── course_package.json     ← 课程结构化数据
│   └── evidence_map.json       ← 来源证据映射
├── scripts/
│   └── search_course_notes.py  ← 关键词搜索脚本
└── agents/
    ├── openai.yaml             ← OpenAI Agent 配置
    └── openclaw.yaml           ← OpenClaw Agent 配置
```

### 如何使用？

#### 方式一：Hermes Agent（推荐）

1. 安装 [Hermes Agent](https://hermes-agent.nousresearch.com)
2. 将 `mechanical-design-assistant` 目录复制到 `~/.hermes/skills/`
3. 直接对话即可，Skill 会自动加载

```bash
# 复制 Skill
cp -r mechanical-design-assistant ~/.hermes/skills/

# 然后在 Hermes 中直接提问
# > 6214轴承的参数是什么？
# > 45号钢调质硬度多少？
# > 齿轮弯曲强度怎么校核？
```

#### 方式二：Claude Code / Codex

将 `mechanical-design-assistant` 目录放到项目中，Agent 会自动识别 SKILL.md 并加载参考文件。

#### 方式三：搜索脚本

```bash
cd mechanical-design-assistant
python scripts/search_course_notes.py "6200"
```

### 蒸馏覆盖范围

| 模块 | 内容 | 课时 |
|------|------|------|
| 01 设计基础 | 公差配合、力学公式、数学数表、制图标准 | 6课 |
| 02 材料工程 | 钢铁/有色金属/非金属材料、热处理工艺 | 6课 |
| 03 制造工艺 | 铸造、锻造、冲压、焊接、机加工 | 6课 |
| 04 零部件设计 | 轴承、轴系、弹簧、螺纹、密封、润滑 | 13课 |
| 05 传动系统 | 齿轮、带链、减速器、螺旋传动 | 8课 |
| 06 流体传动 | 液压传动、液压控制、气压传动 | 6课 |
| 07 人机与结构 | 机构设计、振动控制、机架设计 | 6课 |
| 00 速查表 | 常用材料参数速查 | 1课 |
| **合计** | | **52课** |

### 蒸馏数据统计

- 原始内容：59个 Markdown 文件，2.3MB，51,252行
- 蒸馏产出：135KB 课程笔记 + 2.1MB 完整转录
- 知识点：18个核心概念 / 15条金句 / 17条学习路径 / 54条证据

---

## 🏗️ 结构

```
机械设计手册检索系统
├── 机械设计知识库/          ← 59 个标注好的知识库文件
│   ├── 00_速查表/           ← 常用材料、传动效率、配合、硬度
│   ├── 01_设计基础/         ← 力学公式、公差配合、制图标准
│   ├── 02_材料工程/         ← 黑色/有色金属、热处理、非金属材料
│   ├── 03_制造工艺/         ← 铸造、锻造、冲压、焊接、机加工
│   ├── 04_零部件设计/       ← 轴承、弹簧、螺纹、润滑密封、电机
│   ├── 05_传动系统/         ← 齿轮、带链、减速器
│   ├── 06_流体传动/         ← 液压传动、气压传动
│   ├── 07_人机与结构/       ← 机构设计、机架设计、振动控制
│   └── 08_标准索引/         ← 页码对照表、GB/JB 标准清单
│
├── mechanical-design-assistant/  ← AI Skill（蒸馏产出）
│   ├── SKILL.md
│   ├── references/
│   └── ...
│
├── web_ui.py               ← Web 界面（端口 5231）
├── search.py               ← 核心检索引擎
├── wizard.py               ← 设计向导（自动识别设计场景）
├── bm25_search.py          ← BM25 语义搜索引擎
├── Dockerfile              ← Docker 构建文件
├── docker-compose.yml      ← Docker Compose 配置
├── run.sh                  ← 启动入口
└── ...
```

---

## ⚠️ 版权说明

本仓库仅包含自行整理的知识库文本摘要（Markdown 格式）。

原始 PDF 文件受版权保护，**不包含在本仓库中**。如果您拥有该手册的合法副本，可将 PDF 置于项目根目录使用 PDF 跳转功能。

---

## 💡 适用人群

- 🔩 机械设计工程师 — 快速查标准数据、公式、选型表
- 🎓 机械专业学生 — 课程设计、毕业设计参考
- ⚙️ 产品研发人员 — 标准件选型、材料选择、强度校核
- 🤖 AI Agent 用户 — 通过 Skill 让 AI 成为机械设计助手

---

## 🔗 相关项目

- [lineage-skill](https://github.com/JuneYaooo/lineage-skill) — 课程蒸馏框架
- [Hermes Agent](https://hermes-agent.nousresearch.com) — AI Agent 平台

---

有问题或建议，欢迎提 [Issue](https://github.com/erikgqp8645/mechanical-design-handbook/issues)。
