---
author:
- Marcus Ramberg
draft: false
publishDate: "2020-08-10T00:00:00+02:00"
tags:
- devops
- monitoring
title: Avoid 'no data' in your prometheus queries
---

CLOSED: <span class="timestamp-wrapper"><span class="timestamp">[2020-08-10 Mon 20:57]</span></span>
Have some Prometheus queries that sometimes give no results? For instance error rate when there are no errors. Just append ~or vector(0) and the query will return 0 instead of an empty vector.
