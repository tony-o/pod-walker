# conv_class.t --- test the class holding conversion functions

use v6;
use Test;
use Pod::Walker;

my $def = Walker::Callees.new;

is $def.para("foo"),       "foo", "Default &para is the identity function.";
is $def.named("foo"),      "foo", "Default &named is the identity function.";
is $def.comment("foo"),    "foo", "Default &comment is the identity function.";
is $def.code("foo"),       "foo", "Default &code is the identity function.";
is $def.declarator("foo"), "foo", "Default &declarator is the identity function.";
is $def.table("foo"),      "foo", "Default &table is the identity function.";
is $def.fcode("foo"),      "foo", "Default &fcode is the identity function.";
is $def.heading("foo"),    "foo", "Default &heading is the identity function.";
is $def.item("foo"),       "foo", "Default &item is the identity function.";
is $def.config("foo"),     "foo", "Default &config is the identity function.";

is $def.para("foo", "bar"), "foo", "Default function eats additional arguments";

{
    class FAKE::ERR {
        my $.text = '';
        method print($thing) {
            $!text ~= $thing;
        }
        method clear() {
            $!text = '';
        }
    }

    temp $*ERR = FAKE::ERR.new;

    $def.para("foo");
    is $*ERR.text, '', "Default function does not emit debug info by default.";
    $*ERR.clear;

    my $d2 = Walker::Callees.new(:debug);

    $d2.para("foo", "bar", :baz);
    my $out = "Called with 'foo' to process, as well as Array.new(\"bar\") and (\"baz\" => Bool::True).hash to consider.\n";
    is $*ERR.text, $out, "Default function in debug-based class emits debug info.";
}