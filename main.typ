#import "template.typ": my-template, code
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *



#show: my-template.with(
  title: "Deployment von NixOS im GHG",
  author: "Samson",
)

= Einleitung

In dieser Facharbeit geht es darum, wie man Linux im GHG als Betriebssystem der Arbeitsrechner verwenden koennte. Dabei wird speziell die Verwendung der Distribution NixOS in den Vordergrund gestellte.

== Was ist NixOS

NixOS ist eine deklarative Linux Distribution, das Bedeutet das man Packages, System- und Program Konfigurationen nicht durch Bash Commands wie #raw(lang: "bash", "sudo apt install firefox") taetigt, sondern alles Zentralisiert in einer Systemkonfiguration liegt. Beispielsweise kann man Firefox so Installieren und Konfigurieren:
#code("configuration.nix", ```nix
programs.firefox = {
  enable = true;
  preferences = {
    "privacy.resistFingerprinting" = true;
  };
};
```)


------------Das ganze System kann also mit der Nix Programmiersprache, die man als json mit Funktionen beschreiben koennte, konfiguriert werden. Nix ist Turing Complete und startete als Forschungsprojekt von Dolstra @dolstra2011 an der Universitaet Utrecht im Jahr 2006.

------------Nix entstand ab 2003 als Forschungsprojekt von Eelco Dolstra an der Utrecht University. 2006 veröffentlichte Dolstra seine Dissertation The Purely Functional Software Deployment Model, @dolstra2011 in der die grundlegenden Konzepte von Nix, einem Package Manager und einer Turing Complete Programmiersprache beschrieben wurden.

Durch Nix werden auch die 122'000 Packages deklariert. Diese Nummer ist allerdings kuenstlich Aufgeblaeht. Python 13 Packages und Python 14 Packages machen schon 20'000 aus, diese existieren nur damit man nichts durch einen Imperativen Package Manager wie `pip` installieren muss sondern auch diese Deklarativ einbinden kann.


= Vorteile von NixOS als Betriebssystem fuer Schul PC's
NixOS konfigurieren Beansprucht viel mehr Zeit als ein oder zwei Commands laufen zu lassen, die Vorteile Tauchen auf wenn 100 PC's aufgesetzt werden sollen. Wenn man eine Konfiguration schreibt und Baut, werden direkt alle Versionen der Verlangten Pakete festgesetzt, dadurch kann man die gleiche Konfiguration fuer 10 Jahre ausliefern ohne das irgendwann durch Version-Inkompatibilitaeten Fehler entstehen. Ein Weiterer Vorteil entsteht in der Rollback Funktion von NixOS, da dass Ganze System durch einige Dateien beschrieben ist, kann es sich erlauben, eine minimale Kopie des Systems zu Speichern. Wenn man diese dann Booten wuerde, Bauen sich die beschriebenen Pakete mit ihren Versionen, solang nicht im Nix-Store schon verfuegbar neu.

Da NixOS komplett Deklarativ ist kann man auch keine Binaries aus dem Internet herunterladen und einfach Ausfuehren. Das erhoeht allein schon die Sicherheit, dadurch das Schueler nichts Installieren koennen.

NixOS ermoeglicht Nix Flakes. Mit ihnen kann man fuer ein Projekt genaue "Dependencies" definieren. Angenommen die einen Schueler sollen Python 3.15 mit NumPy lernen und die anderen Python 3.11 mit requests. Dann koennte man je nach Bedarf eine Flake ausgeben und je nach editor diese aktivieren - terminal editors mit `nix develop`, Gui-editors liefern meist ein Plugin.
#code("flake.nix", ```nix
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs@{ ... }: inputs.flake-utils.lib.eachDefaultSystem (
      system: let pkgs = import inputs.nixpkgs { inherit system; }; in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            python315
            # python315Packages.requests
            python315Packages.numpy
          ];
        };
      }
    );
}
```)

Wenn diese Flake gebaut wird, entsteht ein Lock File der dann die Versionen und hashes speichert.

Hier sieht man allerdings auch schon das grosse Problem von Nix, es ist eine Eigene Domain Spezifische Programmiersprache und zudem auch noch eine sehr Schlechte, sie ist Kompliziert und nicht geeignet dafuer das Schueler sie verstehen oder Editieren. Es muss sich also der Lehrer darum kuemmern und dafuer muss er Nix verstehen. Aber fuer diese Facharbeit will ich das Problem aussen vorentlassen.

= 



#pagebreak()

#bibliography("references.bib", title: "Quellen")