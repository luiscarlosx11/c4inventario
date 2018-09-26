﻿/**
 * [Chart.PieceLabel.js]{@link https://github.com/emn178/Chart.PieceLabel.js}
 *
 * @version 0.8.1
 * @author Chen, Yi-Cyuan [emn178@gmail.com]
 * @copyright Chen, Yi-Cyuan 2017
 * @license MIT
 */
(function () {
    function n() { this.drawDataset = this.drawDataset.bind(this) } n.prototype.beforeDatasetsUpdate = function (a) { if (this.parseOptions(a) && "outside" === this.position) { var b = 1.5 * this.fontSize + 2; a.chartArea.top += b; a.chartArea.bottom -= b } }; n.prototype.afterDatasetsDraw = function (a) { this.parseOptions(a) && (this.labelBounds = [], a.config.data.datasets.forEach(this.drawDataset)) }; n.prototype.drawDataset = function (a) {
        for (var b, d = this.ctx, k = this.chartInstance, g = a._meta[Object.keys(a._meta)[0]], m = 0, h = 0; h < g.data.length; h++) {
            var l =
            g.data[h], c = l._view; if (0 !== c.circumference || this.showZero) {
                switch (this.render) { case "value": var e = a.data[h]; this.format && (e = this.format(e)); e = e.toString(); break; case "label": e = k.config.data.labels[h]; break; case "image": e = this.images[h] ? this.loadImage(this.images[h]) : ""; break; default: b = c.circumference / this.options.circumference * 100, b = parseFloat(b.toFixed(this.precision)), m += b, 100 < m && (b -= m - 100, b = parseFloat(b.toFixed(this.precision))), e = b + "%" } "function" === typeof this.render && (e = this.render({
                    label: k.config.data.labels[h],
                    value: a.data[h], percentage: b
                }), "object" === typeof e && (e = this.loadImage(e))); if (!e) break; d.save(); d.beginPath(); d.font = Chart.helpers.fontString(this.fontSize, this.fontStyle, this.fontFamily); if ("outside" === this.position || "border" === this.position && "pie" === k.config.type) {
                    var f = c.outerRadius / 2; var n, p = this.fontSize + 2; var q = c.startAngle + (c.endAngle - c.startAngle) / 2; "border" === this.position ? n = (c.outerRadius - f) / 2 + f : "outside" === this.position && (n = c.outerRadius - f + f + p); q = {
                        x: c.x + Math.cos(q) * n, y: c.y + Math.sin(q) *
                        n
                    }; if ("outside" === this.position) { q.x = q.x < c.x ? q.x - p : q.x + p; var r = c.outerRadius + p }
                } else f = c.innerRadius, q = l.tooltipPosition(); p = this.fontColor; "function" === typeof p ? p = p({ label: k.config.data.labels[h], value: a.data[h], percentage: b, text: e, backgroundColor: a.backgroundColor[h], dataset: a, index: h }) : "string" !== typeof p && (p = p[h] || this.options.defaultFontColor); if (this.arc) r || (r = (f + c.outerRadius) / 2), d.fillStyle = p, d.textBaseline = "middle", this.drawArcText(e, r, c, this.overlap); else {
                    f = this.measureText(e); c = q.x - f.width /
                    2; f = q.x + f.width / 2; var t = q.y - this.fontSize / 2, u = q.y + this.fontSize / 2; (this.overlap || ("outside" === this.position ? this.checkTextBound(c, f, t, u) : l.inRange(c, t) && l.inRange(c, u) && l.inRange(f, t) && l.inRange(f, u))) && this.fillText(e, q, p)
                } d.restore()
            }
        }
    }; n.prototype.parseOptions = function (a) {
        var b = a.options.pieceLabel; return b ? (this.chartInstance = a, this.ctx = a.chart.ctx, this.options = a.config.options, this.render = b.render || b.mode, this.position = b.position || "default", this.arc = b.arc, this.format = b.format, this.precision =
        b.precision || 0, this.fontSize = b.fontSize || this.options.defaultFontSize, this.fontColor = b.fontColor || this.options.defaultFontColor, this.fontStyle = b.fontStyle || this.options.defaultFontStyle, this.fontFamily = b.fontFamily || this.options.defaultFontFamily, this.hasTooltip = a.tooltip._active && a.tooltip._active.length, this.showZero = b.showZero, this.overlap = b.overlap, this.images = b.images || [], !0) : !1
    }; n.prototype.checkTextBound = function (a, b, d, k) {
        for (var g, m, h = this.labelBounds, l = 0; l < h.length; ++l) {
            for (var c = h[l], e =
            [[a, d], [a, k], [b, d], [b, k]], f = 0; f < e.length; ++f) if (m = e[f][0], g = e[f][1], m >= c.left && m <= c.right && g >= c.top && g <= c.bottom) return !1; e = [[c.left, c.top], [c.left, c.bottom], [c.right, c.top], [c.right, c.bottom]]; for (f = 0; f < e.length; ++f) if (m = e[f][0], g = e[f][1], m >= a && m <= b && g >= d && g <= k) return !1
        } h.push({ left: a, right: b, top: d, bottom: k }); return !0
    }; n.prototype.measureText = function (a) { return "string" === typeof a ? this.ctx.measureText(a) : { width: a.width, height: a.height } }; n.prototype.fillText = function (a, b, d) {
        var k = this.ctx; "string" ===
        typeof a ? (k.fillStyle = d, k.textBaseline = "top", k.textAlign = "center", k.fillText(a, b.x, b.y - this.fontSize / 2)) : k.drawImage(a, b.x - a.width / 2, b.y - a.height / 2, a.width, a.height)
    }; n.prototype.loadImage = function (a) { var b = new Image; b.src = a.src; b.width = a.width; b.height = a.height; return b }; n.prototype.drawArcText = function (a, b, d, k) {
        var g = this.ctx, m = d.x, h = d.y, l = d.startAngle; d = d.endAngle; g.save(); g.translate(m, h); h = d - l; l += Math.PI / 2; d += Math.PI / 2; var c = l; m = this.measureText(a); l += (d - (m.width / b + l)) / 2; if (k || !(d - l > h)) if ("string" ===
        typeof a) for (g.rotate(l), k = 0; k < a.length; k++) l = a.charAt(k), m = g.measureText(l), g.save(), g.translate(0, -1 * b), g.fillText(l, 0, 0), g.restore(), g.rotate(m.width / b); else g.rotate((c + d) / 2), g.translate(0, -1 * b), this.fillText(a, { x: 0, y: 0 }); g.restore()
    }; Chart.pluginService.register({ beforeInit: function (a) { a.pieceLabel = new n }, beforeDatasetsUpdate: function (a) { a.pieceLabel.beforeDatasetsUpdate(a) }, afterDatasetsDraw: function (a) { a.pieceLabel.afterDatasetsDraw(a) } })
})();