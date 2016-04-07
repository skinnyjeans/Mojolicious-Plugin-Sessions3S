package Mojolicious::Plugin::Sessions3S;
# ABSTRACT: Manage Sessions Storage, State and Sid generation in Mojolicious

=head1 NAME

Mojolicious::Plugin::Sessions3S - Manage mojolicious sessions Storage, State and SID generation

=head1 DESCRIPTION

This plugins puts you in control of how your sessions are stored, how the state persists
in the client browser and how session Ids are generated.

It provides a drop in replacement for the standard Mojolicious::Sessions mechanism and
will NOT require any change of your application code (except the setup of course).

=head1 SYNOPSIS

  $app->plugin( 'Sessions3S' => {
     state => ..,
     storage => ...,
     sidgen => ...
  });

See L<Mojolicious::Sessions::ThreeS> for the parameters description.

If no arguments are provided, this fallsback to the stock L<Mojolicious::Sessions> behaviour.

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

=head1 COPYRIGHT

This is copyright Jerome Eteve (JETEVE) 2016

With the support of Broadbean UK Ltd. L<http://www.broadbean.co.uk>

=cut

1;
