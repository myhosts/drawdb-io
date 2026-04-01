# drawDB

## 项目简介

**drawDB** 是一个免费、简单、直观的在线数据库图表编辑器和 SQL 生成器，由 drawdb-io 组织开发的开源项目。它允许用户在浏览器中轻松创建数据库实体关系图（ER图），并自动生成相应的 SQL 脚本，无需创建账户或安装复杂软件。

## 核心特性

- **直观界面**：拖放式界面设计，易于使用
- **多数据库支持**：支持 MySQL、PostgreSQL、SQLite、MariaDB、SQL Server 等
- **SQL 生成**：自动从图表生成 SQL 创建脚本
- **导出功能**：支持导出 SQL、JSON、PNG、SVG、PDF 等格式
- **反向工程**：从现有 SQL 脚本导入生成图表
- **实时协作**：通过链接共享图表项目，支持多用户实时协作编辑
- **自定义选项**：明暗主题、键盘快捷键、工作区管理等
- **版本控制**：SQL 脚本版本管理和比较
- **问题检测**：检测和解决图表中的错误，确保脚本正确性

## 技术架构

- **前端**：React + TypeScript + Vite
- **样式**：Tailwind CSS
- **图表**：自定义 Canvas 渲染
- **存储**：本地存储或可选云存储
- **部署**：静态网站部署

## 快速开始

### 在线使用（推荐）

直接访问官方网站：

- <https://drawdb.io/>
- 或者访问 GitHub Pages 版本：<https://gh.drawdb.zhiqiang.wang/>

### 本地开发

```bash
git clone https://github.com/drawdb-io/drawdb
cd drawdb
npm install
npm run dev
```

### 构建

```bash
git clone https://github.com/drawdb-io/drawdb
cd drawdb
npm install
npm run build
```

### Docker 构建

```bash
docker build -t drawdb .
docker run -p 3000:80 drawdb
```

## 功能详情

### 实体关系建模

- 表创建：轻松创建和配置数据库表
- 列定义：定义数据类型、约束、默认值
- 键管理：主键、外键、唯一键、索引管理
- 关系建立：直观建立表间关系
- 注释添加：添加表和列注释文档

### 可视化特性

- 自动排列：智能自动排列表和关系
- 缩放和平移：平滑的缩放和平移导航
- 网格对齐：网格对齐和参考线
- 图层管理：多层图表管理
- 历史记录：操作历史和撤销/重做

### SQL 生成能力

- 方言支持：多种 SQL 方言支持
- 约束生成：自动生成所有约束
- 索引创建：生成适当的索引
- 视图支持：数据库视图生成
- 触发器：基本触发器支持

### 导出导入

- 图像导出：高分辨率 PNG、SVG 导出
- 文档导出：PDF 文档导出带图表
- 代码导出：纯 SQL 脚本导出
- 项目导入：从 JSON 导入现有项目
- SQL 导入：从 SQL 脚本逆向工程

## 兼容性

- **浏览器**：Chrome, Firefox, Safari, Edge (最新版本)
- **数据库**：MySQL, PostgreSQL, SQLite, SQL Server, Oracle
- **设备**：桌面, 平板 (移动设备有限支持)
- **分辨率**：支持高 DPI 和多种分辨率

## 性能指标

- **加载时间**：<3秒初始加载
- **响应时间**：<100ms用户操作
- **图表大小**：支持100+实体的大型图表
- **内存使用**：<50MB典型使用
- **导出速度**：即时SQL生成
