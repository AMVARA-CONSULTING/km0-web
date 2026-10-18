#!/usr/bin/env python3
"""Generate the public presentation PDF (civic dark, matches site presentation).

Writes: public/presentations/km0-digital-tecnologica-kilometro-cero.pdf

Palette and structure follow docs/brand-tokens.md and src/views/Presentation.astro.
Spanish body matches src/i18n/es.json presentation.* (shared download for all locales).
Contact on the CTA slide: info@km0digital.com

Requires: reportlab, system Liberation Sans (IBM Plex Sans TTF is not shipped).
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image
from reportlab.lib.units import inch
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "public" / "presentations" / "km0-digital-tecnologica-kilometro-cero.pdf"
LOGO = ROOT / "public" / "brand" / "logo.png"
FONT_DIR = Path("/usr/share/fonts/truetype/liberation")

# Civic dark tokens (docs/brand-tokens.md)
PAPER = (0x0B / 255, 0x12 / 255, 0x20 / 255)
SNOW = (0x14 / 255, 0x1B / 255, 0x28 / 255)
INK = (0xE6 / 255, 0xE9 / 255, 0xED / 255)
INK_MUTED = (0xE6 / 255 * 0.68, 0xE9 / 255 * 0.68, 0xED / 255 * 0.68)
SIGNAL = (0x2D / 255, 0xD4 / 255, 0xBF / 255)
MIST = (0x2A / 255, 0x33 / 255, 0x44 / 255)

W, H = 13.333 * inch, 7.5 * inch
MARGIN = 0.7 * inch
CONTACT_EMAIL = "info@km0digital.com"


def register_fonts() -> tuple[str, str]:
    regular = FONT_DIR / "LiberationSans-Regular.ttf"
    bold = FONT_DIR / "LiberationSans-Bold.ttf"
    if not regular.exists() or not bold.exists():
        raise SystemExit(f"Liberation Sans not found under {FONT_DIR}")
    pdfmetrics.registerFont(TTFont("KM0Sans", str(regular)))
    pdfmetrics.registerFont(TTFont("KM0Sans-Bold", str(bold)))
    return "KM0Sans", "KM0Sans-Bold"


def fill_bg(c: canvas.Canvas, color: tuple[float, float, float] = PAPER) -> None:
    c.setFillColorRGB(*color)
    c.rect(0, 0, W, H, fill=1, stroke=0)


def hairline(c: canvas.Canvas, y: float) -> None:
    c.setStrokeColorRGB(*MIST)
    c.setLineWidth(1)
    c.line(MARGIN, y, W - MARGIN, y)


def draw_footer(c: canvas.Canvas, page: int, total: int, font: str) -> None:
    c.setFillColorRGB(*INK_MUTED)
    c.setFont(font, 9)
    c.drawString(MARGIN, 0.35 * inch, "km0digital.com · cloud.km0digital.com")
    c.drawRightString(W - MARGIN, 0.35 * inch, f"{page} / {total}")


def draw_kicker(c: canvas.Canvas, text: str, x: float, y: float, font_bold: str) -> None:
    c.setFillColorRGB(*SIGNAL)
    c.setFont(font_bold, 11)
    c.drawString(x, y, text.upper())


def draw_title(c: canvas.Canvas, text: str, x: float, y: float, font_bold: str, size: int = 28) -> float:
    c.setFillColorRGB(*INK)
    c.setFont(font_bold, size)
    c.drawString(x, y, text)
    return y - size * 1.15


def wrap_lines(c: canvas.Canvas, text: str, font: str, size: int, max_width: float) -> list[str]:
    words = text.split()
    lines: list[str] = []
    current = ""
    for word in words:
        trial = word if not current else f"{current} {word}"
        if c.stringWidth(trial, font, size) <= max_width:
            current = trial
        else:
            if current:
                lines.append(current)
            current = word
    if current:
        lines.append(current)
    return lines


def draw_paragraph(
    c: canvas.Canvas,
    text: str,
    x: float,
    y: float,
    font: str,
    size: int,
    max_width: float,
    color: tuple[float, float, float] = INK_MUTED,
    leading: float | None = None,
) -> float:
    lead = leading or size * 1.45
    c.setFillColorRGB(*color)
    c.setFont(font, size)
    for line in wrap_lines(c, text, font, size, max_width):
        c.drawString(x, y, line)
        y -= lead
    return y


def draw_logo(c: canvas.Canvas, right: float, mid_y: float, height: float) -> None:
    """Place logo right-aligned, vertically centered on mid_y, fully on-canvas."""
    if not LOGO.exists():
        return
    with Image.open(LOGO) as im:
        aspect = im.width / float(im.height)
    width = height * aspect
    x = right - width
    y = mid_y - height / 2
    # Keep a small inset from the frame edge
    if x < MARGIN:
        scale = (right - MARGIN) / width
        width *= scale
        height *= scale
        x = MARGIN
        y = mid_y - height / 2
    c.drawImage(str(LOGO), x, y, width=width, height=height, mask="auto")


def slide_title(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    # Quiet signal edge (origin stamp cue, not a rainbow bar)
    c.setFillColorRGB(*SIGNAL)
    c.rect(0, 0, 0.12 * inch, H, fill=1, stroke=0)

    draw_kicker(c, "Presentación", MARGIN, H - 0.9 * inch, bold)
    y = draw_title(c, "Nube y correo en la UE", MARGIN, H - 1.55 * inch, bold, 36)
    y = draw_paragraph(
        c,
        "Cloud y correo en la UE, precio público. Operador local: AMVARA CONSULTING S.L.",
        MARGIN,
        y - 0.15 * inch,
        font,
        16,
        W * 0.52,
        INK_MUTED,
    )
    draw_paragraph(
        c,
        "Kilómetro 0 Digital · KM0 Cloud · KM0 Email",
        MARGIN,
        y - 0.35 * inch,
        bold,
        13,
        W * 0.52,
        SIGNAL,
    )

    # Dominant brand mark on the right (split-bias, not centered SaaS)
    draw_logo(c, W - MARGIN, H * 0.52, 2.6 * inch)
    draw_footer(c, page, total, font)


def slide_why(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Por qué", MARGIN, H - 0.85 * inch, bold)
    y = draw_title(c, "¿Por qué existe KM0?", MARGIN, H - 1.45 * inch, bold, 30)
    y = draw_paragraph(
        c,
        "Porque quieres archivos y correo sin que tu perfil sea el producto. Somos el operador local.",
        MARGIN,
        y - 0.2 * inch,
        font,
        18,
        W - 2 * MARGIN,
        INK,
        leading=26,
    )
    draw_footer(c, page, total, font)


def slide_compare(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Comparativa", MARGIN, H - 0.85 * inch, bold)
    draw_title(c, "Nube habitual vs KM0", MARGIN, H - 1.45 * inch, bold, 28)

    rows = [
        ("Tu perfil es el producto", "No vendemos datos"),
        ("Soporte lejano o automatizado", "Soporte local humano"),
        ("Precios opacos", "Tarifa pública sobre coste real"),
    ]
    table_top = H - 2.2 * inch
    col_w = (W - 2 * MARGIN) / 2
    row_h = 1.15 * inch

    # Header band
    c.setFillColorRGB(*SNOW)
    c.rect(MARGIN, table_top - 0.55 * inch, W - 2 * MARGIN, 0.55 * inch, fill=1, stroke=0)
    c.setFillColorRGB(*INK)
    c.setFont(bold, 14)
    c.drawString(MARGIN + 0.25 * inch, table_top - 0.38 * inch, "Grandes plataformas")
    c.drawString(MARGIN + col_w + 0.25 * inch, table_top - 0.38 * inch, "KM0")

    y = table_top - 0.55 * inch
    for i, (usual, km0) in enumerate(rows):
        y -= row_h
        if i % 2 == 0:
            c.setFillColorRGB(*SNOW)
            c.rect(MARGIN, y, W - 2 * MARGIN, row_h, fill=1, stroke=0)
        c.setStrokeColorRGB(*MIST)
        c.setLineWidth(0.5)
        c.line(MARGIN, y, W - MARGIN, y)
        c.setFillColorRGB(*INK_MUTED)
        c.setFont(font, 14)
        c.drawString(MARGIN + 0.25 * inch, y + row_h * 0.42, usual)
        c.setFillColorRGB(*INK)
        c.setFont(bold, 14)
        c.drawString(MARGIN + col_w + 0.25 * inch, y + row_h * 0.42, km0)

    draw_footer(c, page, total, font)


def slide_community(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Comunidad", MARGIN, H - 0.85 * inch, bold)
    y = draw_title(c, "Hecho cerca de la gente", MARGIN, H - 1.45 * inch, bold, 28)
    c.setFillColorRGB(*SIGNAL)
    c.setFont(bold, 14)
    c.drawString(MARGIN, y - 0.1 * inch, "Familias, escuelas, comercios de proximidad")
    draw_paragraph(
        c,
        "Operador local: servicios útiles, sin convertir tu uso cotidiano en publicidad.",
        MARGIN,
        y - 0.55 * inch,
        font,
        16,
        W * 0.62,
        INK_MUTED,
        leading=24,
    )
    draw_footer(c, page, total, font)


def slide_cloud(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Producto", MARGIN, H - 0.85 * inch, bold)
    y = draw_title(c, "KM0 Cloud", MARGIN, H - 1.45 * inch, bold, 30)
    y = draw_paragraph(
        c,
        "Archivos y colaboración desde el navegador o el móvil, con datos en la UE.",
        MARGIN,
        y - 0.15 * inch,
        font,
        16,
        W * 0.7,
        INK_MUTED,
    )
    features = [
        "Sincronización en Android, iOS y web",
        "Edición de documentos en la nube",
        "Enlaces para compartir con control de acceso",
        "URL: cloud.km0digital.com",
    ]
    y -= 0.45 * inch
    for item in features:
        c.setFillColorRGB(*SIGNAL)
        c.circle(MARGIN + 0.12 * inch, y + 0.12 * inch, 0.08 * inch, fill=1, stroke=0)
        c.setFillColorRGB(*INK)
        c.setFont(font, 15)
        c.drawString(MARGIN + 0.4 * inch, y, item)
        y -= 0.55 * inch
    draw_footer(c, page, total, font)


def slide_values(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Operación", MARGIN, H - 0.85 * inch, bold)
    draw_title(c, "Cómo operamos", MARGIN, H - 1.45 * inch, bold, 28)
    items = [
        ("Cercano", "Soporte en tu idioma, sin call center anónimo."),
        ("Transparente", "Precio y operaciones visibles; sin letra pequeña de producto."),
        ("Sostenible", "Cobramos lo necesario para mantener el servicio limpio."),
    ]
    y = H - 2.2 * inch
    for title, body in items:
        hairline(c, y + 0.55 * inch)
        c.setFillColorRGB(*INK)
        c.setFont(bold, 16)
        c.drawString(MARGIN, y + 0.2 * inch, title)
        c.setFillColorRGB(*INK_MUTED)
        c.setFont(font, 13)
        c.drawString(MARGIN + 2.4 * inch, y + 0.2 * inch, body)
        y -= 1.05 * inch
    draw_footer(c, page, total, font)


def slide_privacy_security(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Confianza", MARGIN, H - 0.85 * inch, bold)
    y = draw_title(c, "Privacidad y seguridad", MARGIN, H - 1.45 * inch, bold, 28)
    y = draw_paragraph(
        c,
        "No usamos archivos ni correos para publicidad. No vendemos datos.",
        MARGIN,
        y - 0.1 * inch,
        font,
        15,
        W - 2 * MARGIN,
        INK_MUTED,
    )
    c.setFillColorRGB(*SIGNAL)
    c.setFont(bold, 14)
    c.drawString(MARGIN, y - 0.25 * inch, "Cero venta de datos")

    items = [
        ("Infraestructura en la UE", "Datos alojados en la Unión Europea bajo RGPD."),
        ("Cifrado en tránsito", "HTTPS/TLS en web y servicios; controles ISO/IEC 27001:2022."),
        ("Software verificable", "Plataforma abierta donde tiene sentido auditar el tratamiento."),
    ]
    y = H - 3.6 * inch
    for title, body in items:
        c.setFillColorRGB(*INK)
        c.setFont(bold, 14)
        c.drawString(MARGIN, y, title)
        c.setFillColorRGB(*INK_MUTED)
        c.setFont(font, 12)
        c.drawString(MARGIN + 3.3 * inch, y, body)
        y -= 0.7 * inch
    draw_footer(c, page, total, font)


def slide_roadmap(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    draw_kicker(c, "Camino", MARGIN, H - 0.85 * inch, bold)
    draw_title(c, "Camino", MARGIN, H - 1.45 * inch, bold, 28)
    steps = [
        ("1", "Cimientos", "Servidores bajo control propio."),
        ("2", "Lanzamiento", "KM0 Cloud en producción (web y móviles)."),
        ("3", "Identidad", "Acceso unificado local."),
        ("4", "Siguiente", "Priorizamos lo que la comunidad pide."),
    ]
    y = H - 2.3 * inch
    for num, title, body in steps:
        c.setFillColorRGB(*SIGNAL)
        c.setFont(bold, 18)
        c.drawString(MARGIN, y, f"{num}.")
        c.setFillColorRGB(*INK)
        c.setFont(bold, 16)
        c.drawString(MARGIN + 0.55 * inch, y, title)
        c.setFillColorRGB(*INK_MUTED)
        c.setFont(font, 13)
        c.drawString(MARGIN + 3.0 * inch, y, body)
        y -= 0.95 * inch
    draw_footer(c, page, total, font)


def slide_cta(c: canvas.Canvas, fonts: tuple[str, str], page: int, total: int) -> None:
    font, bold = fonts
    fill_bg(c)
    c.setFillColorRGB(*SIGNAL)
    c.rect(0, 0, 0.12 * inch, H, fill=1, stroke=0)

    draw_kicker(c, "Siguiente paso", MARGIN, H - 0.95 * inch, bold)
    y = draw_title(c, "Abre Cloud o escríbenos", MARGIN, H - 1.65 * inch, bold, 32)
    draw_paragraph(
        c,
        "Producto en vivo, precio público, soporte humano cerca de El Masnou.",
        MARGIN,
        y - 0.15 * inch,
        font,
        15,
        W * 0.55,
        INK_MUTED,
    )

    links = [
        ("Web", "km0digital.com"),
        ("Cloud", "cloud.km0digital.com"),
        ("Contacto", CONTACT_EMAIL),
    ]
    y = H - 3.6 * inch
    for label, value in links:
        c.setFillColorRGB(*INK_MUTED)
        c.setFont(font, 12)
        c.drawString(MARGIN, y + 0.28 * inch, label)
        c.setFillColorRGB(*INK)
        c.setFont(bold, 18)
        c.drawString(MARGIN, y - 0.05 * inch, value)
        y -= 0.95 * inch

    draw_logo(c, W - MARGIN, H * 0.48, 2.2 * inch)
    draw_footer(c, page, total, font)


def main() -> None:
    fonts = register_fonts()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    c = canvas.Canvas(str(OUT), pagesize=(W, H))
    c.setTitle("KM0 Digital - Tecnológica de kilómetro cero")
    c.setAuthor("Kilómetro 0 Digital / AMVARA CONSULTING S.L.")
    c.setSubject("Presentación pública alineada con km0digital.com")

    builders = [
        slide_title,
        slide_why,
        slide_compare,
        slide_community,
        slide_cloud,
        slide_values,
        slide_privacy_security,
        slide_roadmap,
        slide_cta,
    ]
    total = len(builders)
    for i, build in enumerate(builders, start=1):
        build(c, fonts, i, total)
        c.showPage()

    c.save()
    size_kb = OUT.stat().st_size / 1024
    print(f"Wrote {OUT} ({size_kb:.0f} KB)")
    print(f"Contact email: {CONTACT_EMAIL}")


if __name__ == "__main__":
    main()
