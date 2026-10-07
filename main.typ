#import "template.typ": my-template, code
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *



#show: my-template.with(
  title: "Deployment von NixOS im GHG",
  author: "Samson",
)

= Einleitung

In dieser Facharbeit geht es darum, wie man Linux im GHG als Betriebssystem der Arbeitsrechner verwenden koennte. Dabei wird speziell die Verwendung der Distribution NixOS in den Vordergrund gestellte.

= Nix


Die Grundlagen von Nix entstanden ab 2003 als Forschungsprojekt von Eelco Dolstra in seiner 2006 veroeffentlichten These @dolstra2011.


== Nix Language

Nix ist eine Turing-Komplette, Pure Funktionale, Domain Spezifizierte, Lazy Evaluierte und Dynamisch geschriebene Programmiersprache, in der die Beschreibung von Paketen und die Konfiguration von NixOS vorgenommen wird.

== Nix Package Manager und Derivationen

Die Sprache Nix bietet Funktionen zur Beschreibung von Build-Anweisungen für Pakete. Diese werden zu Nix-Derivationen kompiliert, die (für den Nix-Builder) genau beschreiben, wie das Paket erstellt wird.

Den schritt des Kompilierens und des Bauens uebernimmt der Nix Package Manager. 140'000 Nix Pakete (nixpkgs) @nixpkgs werden momentan auf github:NixOS/nixpkgs gehostet.


== Nix Hashes

Der Nix Hash ist wie ein Fingerabdruck einer Datei, er ist nicht nur von dem Output abhängig (z.B. einer Binary wie "vi") sondern auch von den Dependencies mit denen diese Gebaut wurde, dieser wird Benutzt um zu Verifizieren ob der Build Output exact der Spezifikation entspricht. 

== Nix Store

Im Nix Store, der unter `/nix/store/` liegt, werden alle Packages und Dateien unveränderlich gespeichert. Das layout sieht wie folgt aus: `Hash + Name + Version` beispielsweise fuer das Package `hello` ist der Pfad "/nix/store/xl1h9i29pgq2q5cszjhm5wpfxfbbqwyi-hello-2.12.3/bin/hello". Nur weil ein Package im Store ist, ist es allerdings nicht unbedingt im Pfad und kann somit nicht benutzt werden.

== NixOS

NixOS ist eine deklarative Linux Distribution, man bestimmt installierte Programme und alle Konfigurationen, beispielsweise Benutzer, durch die Nix Sprache typischer Weise im Folder `/etc/nixos`. Man kann Firefox beispielsweise so installieren:  
#code("configuration.nix", ```nix
programs.firefox = {
  enable = true;
  preferences = {
    "privacy.resistFingerprinting" = true;
  };
};
```)

Nach jeder Veraenderung der Konfiguration kann man eine neue Generation des Systems bauen und aktivieren mit `sudo nixos-rebuild switch`. Allerdings werden alte Systembeschreibungen weiterhin behalten, dass ermoeglicht Rollbacks ohne viel Speicherplatz zu verwenden. Wenn man von Generation 1 zu Generation 2 ein Programm entfernt, bleibt dieses jedoch im Nix Store ausser man lehrt den store.

#pagebreak()

#bibliography("references.bib", title: "Quellen")


