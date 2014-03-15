# Walker.pm6 --- class and functions for walking a Pod tree.

use v6;

sub def_callee($text, *@a, *%b, :$debug) {
    note "Called with '$text' to process, as well as {@a.perl} and {%b.perl} to consider." if $debug;
    $text;
}

class Walker::Callees {
    has %!funcs;

    has $.debug = False;

    submethod BUILD(:$!debug, *%OPTS) {
        for <para named comment code declarator table fcode heading item config> {
            %!funcs{$_} = %OPTS{$_} // &def_callee;
        }
    }

    method new(:&para, :&named, :&comment, :&code, :&declarator, :&table, :&fcode, :&heading, :&item, :&config, :$debug) {
        self.bless(:$debug, :&para, :&named, :&comment, :&code,
            :&declarator, :&table, :&fcode, :&heading,
            :&item, :&config);
    }

    method debug-ON { $!debug = True; }
    method debug-OFF { $!debug = False; }

    method set-para(&f)       { %!funcs<para>       = &f; }
    method set-named(&f)      { %!funcs<named>      = &f; }
    method set-comment(&f)    { %!funcs<comment>    = &f; }
    method set-code(&f)       { %!funcs<code>       = &f; }
    method set-declarator(&f) { %!funcs<declarator> = &f; }
    method set-table(&f)      { %!funcs<table>      = &f; }
    method set-fcode(&f)      { %!funcs<fcode>      = &f; }
    method set-heading(&f)    { %!funcs<heading>    = &f; }
    method set-item(&f)       { %!funcs<item>       = &f; }
    method set-config(&f)     { %!funcs<config>     = &f; }

    method para(|a)       { %!funcs<para>\     .(|a, :$!debug) }
    method named(|a)      { %!funcs<named>\    .(|a, :$!debug) }
    method comment(|a)    { %!funcs<comment>\  .(|a, :$!debug) }
    method code(|a)       { %!funcs<code>\     .(|a, :$!debug) }
    method declarator(|a) { %!funcs<declarator>.(|a, :$!debug) }
    method table(|a)      { %!funcs<table>\    .(|a, :$!debug) }
    method fcode(|a)      { %!funcs<fcode>\    .(|a, :$!debug) }
    method heading(|a)    { %!funcs<heading>\  .(|a, :$!debug) }
    method item(|a)       { %!funcs<item>\     .(|a, :$!debug) }
    method config(|a)     { %!funcs<config>\   .(|a, :$!debug) }
}