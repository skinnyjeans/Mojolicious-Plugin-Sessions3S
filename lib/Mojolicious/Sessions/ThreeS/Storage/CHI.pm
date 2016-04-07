package Mojolicious::Sessions::ThreeS::Storage::CHI;

use Mojo::Base qw/Mojolicious::Sessions::ThreeS::Storage/;

use JSON;

=head1 NAME

Mojolicious::Sessions::ThreeS::Storage::CHI - An adapter to store sessions in a CHI instance.

=head1 SYNOPSIS

  my $storage = Mojolicious::Sessions::ThreeS::Storage::CHI->new({ chi => .. a CHI instance .. });

  # Use $storage in the Mojolicious::Sessions::ThreeS instance (or through the plugin):

  $app->sessions( Mojolicious::Sessions::ThreeS->new({ storage => $storage , state => ... } );

Note that you WILL have to depend on CHI and on JSON in your application to use this storage.

This distribution does not add these to the runtime dependencies to avoid clutter.

=cut

has 'chi';
has 'json' => sub{
    my $json = JSON->new();
    $json->ascii( 1 );
    # Encode stuff in ascii so there is no risk
    # of bad decoding.
    return $json;
};

=head2 get_session

See L<Mojolicious::Sessions::ThreeS::Storage>

=cut

sub get_session{
    my ($self, $session_id) = @_;
    my $value =  $self->chi->get( $session_id );
    unless( $value ){ return; }
    return $self->json()->decode( $value );
}

=head2 store_session

See L<Mojolicious::Sessions::ThreeS::Storage>

=cut

sub store_session {
    my ( $self, $session_id, $session ) = @_;
    my $expires = $session->{expires};
    my $value   = $self->json()->encode($session);
    $self->chi->set(
        $session_id,
        $value,
        (
            $expires ? { expires_at => $expires, expires_variance => 0.15 } : ()
        )
    );
}

=head2 remove_session_id

See L<Mojolicious::Sessions::ThreeS::Storage>

=cut

sub remove_session_id{
    my ($self, $session_id) = @_;
    $self->chi->remove( $session_id );
}

1;
