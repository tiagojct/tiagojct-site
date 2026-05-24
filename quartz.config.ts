import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"
import { Citations } from "@quartz-community/citations"

/**
 * tiagojct.eu — Quartz configuration
 * Pequod palette, Atkinson Hyperlegible font stack
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Tiago Jacinto",
    pageTitleSuffix: "",
    enableSPA: true,
    enablePopovers: true,
    analytics: {
      provider: "google",
      tagId: "G-LKPMZWRS99",
    },
    locale: "en-US",
    baseUrl: "tiagojct.eu",
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Atkinson Hyperlegible",
        body: "Atkinson Hyperlegible",
        code: "JetBrains Mono",
      },
      colors: {
        lightMode: {
          light: "#F7F3EE",     // Log 50 — warm cream bg
          lightgray: "#DBC9B6", // Log 150 — borders
          gray: "#A16E50",      // Log 400 — muted
          darkgray: "#163F54",  // Log 700 — body text
          dark: "#0D2F42",      // Log 800 — headings
          secondary: "#163F54", // Log 700 — links
          tertiary: "#BD8C68",  // Log 300 — accent/hover
          highlight: "rgba(207, 173, 142, 0.15)",
          textHighlight: "#DEC57788",
        },
        darkMode: {
          light: "#0B1720",     // Log 950 — deep navy bg
          lightgray: "#163F54", // Log 700 — borders
          gray: "#A16E50",      // Log 400 — muted
          darkgray: "#DBC9B6",  // Log 150 — body text
          dark: "#EAE1D7",      // Log 100 — headings
          secondary: "#BD8C68", // Log 300 — links
          tertiary: "#CFAD8E",  // Lighter amber — hover
          highlight: "rgba(189, 140, 104, 0.15)",
          textHighlight: "#DEC57788",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
      Citations({
        bibliographyFile: "./bibliography.bib",
        csl: "./nature.csl",
        linkCitations: true,
      }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      Plugin.CustomOgImages(),
    ],
  },
}

export default config
