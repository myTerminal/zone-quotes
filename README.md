# zone-quotes

[![Marmalade](https://img.shields.io/badge/marmalade-available-8A2A8B.svg)](https://marmalade-repo.org/packages/zone-quotes)  
[![License](https://img.shields.io/badge/LICENSE-GPL%20v3.0-blue.svg)](https://www.gnu.org/licenses/gpl.html)

A zone program to display quotes from a specific collection

![Demo](images/demo.gif)

## Installation

### Manual

Save the file *zone-quotes.el* to disk and add the directory containing it to `load-path` using a command in your *.emacs* file like:

    (add-to-list 'load-path "~/.emacs.d/")

The above line assumes that you've placed the file into the Emacs directory '.emacs.d'.

Start the package with:

    (require 'zone-quotes)

### Marmalade

If you have Marmalade added as a repository to your Emacs, you can just install *zone-quotes* with

    M-x package-install zone-quotes RET

## Usage

Specify the quotes you want, to be shown while zoning out

    (zone-quotes-set-quotes (list "'I don't need luck. I have ammo.' - Grunt"
                                  "'Is submission not preferable to extinction?' - Saren"
                                  "'Having a bad day Shepard?' - Liara"))

Set `zone-pgm-quotes` as one of the zone programs

    (setq zone-programs
          [zone-pgm-quotes])

and activate zoning by specifying a delay

    (zone-when-idle 30)

Alternatively you can run `zone-quotes` directly

    (zone-quotes)
