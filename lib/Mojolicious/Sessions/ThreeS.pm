package Mojolicious::Sessions::ThreeS;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Sessions';

=head1 NAME

Mojolicious::Sessions:ThreeS - A Mojolicious Sessions manager that supports controlling Storage, State and Sid generation.

=head1 SYNOPSIS

You can use this directly when you build your mojolicious App:

 package My::App;
 use Mojo::Base 'Mojolicious';

 use Mojolicious::Sessions:ThreeS;

 sub startup{
   my ($app) = @_;
   ...
   $app->sessions( Mojolicious::Sessions:ThreeS->new(...) );
   ...
 }

Or as a plugin, with exactly the same arguments. See L<Mojolicious::Plugin::Sessions3S>.

=cut

=head2 new

Builds an instance of this.

=cut

sub new{
    my ( $class ) = ( shift );

    my $self = $class->SUPER::new( @_ );

    return $self;
}

=head2 was_set

This was set with explicit store, storage and sid generator.

Usage:

  if ( $this->was_set() ){
     ...
  }

=cut

sub was_set{
    my ($self) = @_;
    return 0;
}

=head2 load

Implements load from L<Mojolicious::Sessions>

=cut

sub load{
    my ($self, $controller) = @_;

    unless( $self->was_set() ){
        return $self->SUPER::load( $controller );
    }
}

=head2 store

Implements store from L<Mojolicious::Sessions>

=cut

sub store{
    my ($self, $controller) = @_;

    unless( $self->was_set() ){
        return $self->SUPER::store( $controller );
    }
}

1;

