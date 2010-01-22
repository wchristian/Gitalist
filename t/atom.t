#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use FindBin qw/$Bin/;

BEGIN {
    $ENV{GITALIST_CONFIG} = $Bin;
    $ENV{GITALIST_REPO_DIR} = '';
    use_ok 'Catalyst::Test', 'Gitalist';
}

my $res = request('/repo1/atom');
ok $res->is_success;

TODO: {
    local $TODO = "Does not work yet. Need similar info to RSS feed";
    like $res->content, qr{link>http://localhost/repo1</link};
    like $res->content, qr{description>some test repository</description};
}
like $res->content, qr{add dir1/file2</div};
like $res->content, qr{<id>http://localhost/repo1/36c6c6708b8360d7023e8a1649c45bcf9b3bd818</id};
like $res->content, qr{title>add dir1/file2</title};

done_testing;