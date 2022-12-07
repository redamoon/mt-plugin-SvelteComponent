package SvelteComponent::Callbacks;

use strict;
use warnings;
use utf8;
use MT::Util;

sub plugin {
    return MT->component('SvelteComponent');
}

sub template_source_header {
    my ( $cb, $app, $tmpl_ref ) = @_;
    my $app_vars;
    my $p         = plugin();
    my $static_path        = $app->static_path;
    my $static_plugin_path = $static_path . $p->envelope . '/';
    $app_vars->{static_path}        = $static_path;
    $app_vars->{static_plugin_path} = $static_plugin_path;

    $$tmpl_ref =~ s!(<head[^>]*>)!$1\n!;

    my $svelte_component_url = $static_plugin_path . 'js/svelte-component.min.js';

    my $out = <<__EOD__;

    <script type="module" crossorigin src="$svelte_component_url"></script>
__EOD__

    $$tmpl_ref =~ s!</head>!$out</head>!g;
}
1;
