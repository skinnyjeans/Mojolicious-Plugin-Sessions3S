package Mojolicious::Plugin::Sessions3S;
# ABSTRACT: Manage Sessions Storage, State and Sid generation in Mojolicious

=head1 NAME

Mojolicious::Plugin::Sessions3S - Manage mojolicious sessions Storage, State and SID generation

=cut

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

use Mojolicious::Sessions::ThreeS;

=head2 register

Implementation for L<Mojolicious::Plugin> base class

=cut

sub register{
    my ($self, $app, $args) = @_;
    $args ||= {};
    unless( ( ref($args) || '' ) eq 'HASH' ){
        confess("Argument to ".ref($self)." should be an HashRef");
    }
    my $sessions_manager = Mojolicious::Sessions::ThreeS->new( $args );
    $app->sessions( $sessions_manager );
}


1;
