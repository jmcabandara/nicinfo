# Copyright (C) 2011,2012,2013,2014 American Registry for Internet Numbers
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
# IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


require 'stringio'
require 'spec_helper'
require 'rspec'
require_relative '../lib/nicinfo/nicinfo_logger'
require_relative '../lib/nicinfo/data_tree'

describe 'data tree tests' do

  it 'should test to_log' do

    #setup the logger
    logger = NicInfo::Logger.new
    logger.data_out = StringIO.new
    logger.data_amount = NicInfo::DataAmount::EXTRA_DATA
    logger.color_scheme = NicInfo::ColorScheme::NONE

    #do a tree
    tree = NicInfo::DataTree.new

    #create the first root
    root1 = NicInfo::DataNode.new( "first root" )
    root1.add_child( NicInfo::DataNode.new( "first child of first root" ) )
    root1.add_child( NicInfo::DataNode.new( "second child of first root" ) )

    #create the second root
    root2 = NicInfo::DataNode.new( "second root" )
    r2c1 = NicInfo::DataNode.new( "first child of second root" )
    r2c1.add_child( NicInfo::DataNode.new("first child of first child of second root" ) )
    r2c1.add_child( NicInfo::DataNode.new("second child of first child of second root" ) )
    root2.add_child( r2c1 )
    root2.add_child( NicInfo::DataNode.new( "second child of second root" ) )
    r2c3 = NicInfo::DataNode.new( "third child of second root" )
    r2c3c1 = NicInfo::DataNode.new( "first child of third child of second root" )
    r2c3c1.add_child( NicInfo::DataNode.new("first child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("second child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("third child of first child of third child of second root" ) )
    r2c3.add_child( r2c3c1 )
    r2c3.add_child( NicInfo::DataNode.new("second child of third child of second root" ) )
    r2c3.add_child( NicInfo::DataNode.new("third child of third child of second root" ) )
    root2.add_child( r2c3 )
    r2c4 = NicInfo::DataNode.new( "fourth child of second root" )
    r2c4.add_child( NicInfo::DataNode.new("first child of fourth child of second root" ) )
    r2c4.add_child( NicInfo::DataNode.new("second child of fourth child of second root" ) )
    r2c4.add_child( NicInfo::DataNode.new("third child of fourth child of second root" ) )
    root2.add_child( r2c4 )

    #create the third root
    root3 = NicInfo::DataNode.new( "third root" )
    root3.add_child( NicInfo::DataNode.new( "first child of third root" ) )
    root3.add_child( NicInfo::DataNode.new( "second child of third root" ) )

    tree.add_root( root1 )
    tree.add_root( root2 )
    tree.add_root( root3 )

    tree.to_extra_log( logger )

    expected = <<EXPECTED_LOG
[ RESPONSE DATA ]  
first root
  |- first child of first root
  `- second child of first root
second root
  |- first child of second root
  |  |- first child of first child of second root
  |  `- second child of first child of second root
  |- second child of second root
  |- third child of second root
  |  |- first child of third child of second root
  |  |  |- first child of first child of third child of second root
  |  |  |- second child of first child of third child of second root
  |  |  `- third child of first child of third child of second root
  |  |- second child of third child of second root
  |  `- third child of third child of second root
  `- fourth child of second root
     |- first child of fourth child of second root
     |- second child of fourth child of second root
     `- third child of fourth child of second root
third root
  |- first child of third root
  `- second child of third root
EXPECTED_LOG

    expect( logger.data_out.string ).to eq( expected )
=begin
    puts
    puts expected
    puts
    puts logger.data_out.string
=end

  end

  it 'should test to_log with annotate' do

    #setup the logger
    logger = NicInfo::Logger.new
    logger.data_out = StringIO.new
    logger.data_amount = NicInfo::DataAmount::EXTRA_DATA
    logger.color_scheme = NicInfo::ColorScheme::NONE

    #do a tree
    tree = NicInfo::DataTree.new

    #create the first root
    root1 = NicInfo::DataNode.new( "first root", "data" )
    root1.add_child( NicInfo::DataNode.new( "first child of first root", "data" ) )
    root1.add_child( NicInfo::DataNode.new( "second child of first root", "data" ) )

    #create the second root
    root2 = NicInfo::DataNode.new( "second root" )
    r2c1 = NicInfo::DataNode.new( "first child of second root" )
    r2c1.add_child( NicInfo::DataNode.new("first child of first child of second root" ) )
    r2c1.add_child( NicInfo::DataNode.new("second child of first child of second root" ) )
    root2.add_child( r2c1 )
    root2.add_child( NicInfo::DataNode.new( "second child of second root" ) )
    r2c3 = NicInfo::DataNode.new( "third child of second root" )
    r2c3c1 = NicInfo::DataNode.new( "first child of third child of second root" )
    r2c3c1.add_child( NicInfo::DataNode.new("first child of first child of third child of second root", "data" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("second child of first child of third child of second root", "data" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("third child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("fourth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("fifth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("sixth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("seventh child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("eighth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("ninth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("tenth child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("eleventh child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("twelth child of first child of third child of second root" ) )
    r2c3c1c13 = NicInfo::DataNode.new( "thirteenth child of first child of third child of second root" )
    r2c3c1c13.alert=true
    r2c3c1.add_child( r2c3c1c13 )
    r2c3.add_child( r2c3c1 )
    r2c3.add_child( NicInfo::DataNode.new("second child of third child of second root" ) )
    r2c3.add_child( NicInfo::DataNode.new("third child of third child of second root" ) )
    root2.add_child( r2c3 )
    r2c4 = NicInfo::DataNode.new( "fourth child of second root", "data" )
    r2c4.add_child( NicInfo::DataNode.new("first child of fourth child of second root", "data" ) )
    r2c4.add_child( NicInfo::DataNode.new("second child of fourth child of second root", "data" ) )
    r2c4.add_child( NicInfo::DataNode.new("third child of fourth child of second root", "data" ) )
    root2.add_child( r2c4 )

    #create the third root
    root3 = NicInfo::DataNode.new( "third root" )
    root3.add_child( NicInfo::DataNode.new( "first child of third root" ) )
    root3.add_child( NicInfo::DataNode.new( "second child of third root" ) )

    tree.add_root( root1 )
    tree.add_root( root2 )
    tree.add_root( root3 )

    tree.to_extra_log( logger, true )

    expected = <<EXPECTED_LOG
[ RESPONSE DATA ]  
  1= first root
     |--- 1= first child of first root
     `--- 2= second child of first root
  2. second root
     |--- 1. first child of second root
     |    |--- 1. first child of first child of second root
     |    `--- 2. second child of first child of second root
     |--- 2. second child of second root
     |--- 3. third child of second root
     |    |--- 1. first child of third child of second root
     |    |    |--- 1= first child of first child of third child of second root
     |    |    |--- 2= second child of first child of third child of second root
     |    |    |--- 3. third child of first child of third child of second root
     |    |    |--- 4. fourth child of first child of third child of second root
     |    |    |--- 5. fifth child of first child of third child of second root
     |    |    |--- 6. sixth child of first child of third child of second root
     |    |    |--- 7. seventh child of first child of third child of second root
     |    |    |--- 8. eighth child of first child of third child of second root
     |    |    |--- 9. ninth child of first child of third child of second root
     |    |    |-- 10. tenth child of first child of third child of second root
     |    |    |-- 11. eleventh child of first child of third child of second root
     |    |    |-- 12. twelth child of first child of third child of second root
     |    |    `---- # thirteenth child of first child of third child of second root
     |    |--- 2. second child of third child of second root
     |    `--- 3. third child of third child of second root
     `--- 4= fourth child of second root
          |--- 1= first child of fourth child of second root
          |--- 2= second child of fourth child of second root
          `--- 3= third child of fourth child of second root
  3. third root
     |--- 1. first child of third root
     `--- 2. second child of third root
EXPECTED_LOG

    expect( logger.data_out.string ).to eq( expected )
=begin
    puts
    puts expected
    puts
    puts logger.data_out.string
=end

  end

  it 'should test find_data' do

    #do a tree
    tree = NicInfo::DataTree.new

    #create the first root
    root1 = NicInfo::DataNode.new( "first root", "handle:root1", "http:root1", "data:root1" )
    root1.add_child( NicInfo::DataNode.new( "first child of first root", "handle:root1child1", "http:root1child1", "data:root1child1" ) )
    root1.add_child( NicInfo::DataNode.new( "second child of first root", "handle:root1child2", "http:root1child2", "data:root1child2" ) )

    #create the second root
    root2 = NicInfo::DataNode.new( "second root", "handle:root2", "http:root2", "data:root2" )
    r2c1 = NicInfo::DataNode.new( "first child of second root", "handle:root2child1", "http:root2child1", "data:root2child1" )
    r2c1.add_child( NicInfo::DataNode.new("first child of first child of second root" ) )
    r2c1.add_child( NicInfo::DataNode.new("second child of first child of second root" ) )
    root2.add_child( r2c1 )
    root2.add_child( NicInfo::DataNode.new( "second child of second root", "handle:root2child2", "http:root2child2", "data:root2child2" ) )
    r2c3 = NicInfo::DataNode.new( "third child of second root" )
    r2c3c1 = NicInfo::DataNode.new( "first child of third child of second root" )
    r2c3c1.add_child( NicInfo::DataNode.new("first child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("second child of first child of third child of second root" ) )
    r2c3c1.add_child( NicInfo::DataNode.new("third child of first child of third child of second root" ) )
    r2c3.add_child( r2c3c1 )
    r2c3.add_child( NicInfo::DataNode.new("second child of third child of second root" ) )
    r2c3.add_child( NicInfo::DataNode.new("third child of third child of second root" ) )
    root2.add_child( r2c3 )
    r2c4 = NicInfo::DataNode.new( "fourth child of second root", "handle:root2child4", "http:root2child4", "data:root2child4" )
    r2c4.add_child( NicInfo::DataNode.new("first child of fourth child of second root", "handle:root2child4child1", "http:root2child4child1", "data:root2child4child1" ) )
    r2c4.add_child( NicInfo::DataNode.new("second child of fourth child of second root", "handle:root2child4child2", "http:root2child4child2", "data:root2child4child2" ) )
    r2c4.add_child( NicInfo::DataNode.new("third child of fourth child of second root", "handle:root2child4child3", "http:root2child4child3", "data:root2child4child3" ) )
    root2.add_child( r2c4 )

    #create the third root
    root3 = NicInfo::DataNode.new( "third root", "handle:root3", "http:root3", "data:root3" )
    root3.add_child( NicInfo::DataNode.new( "first child of third root", "handle:root3child1", "http:root3child1", "data:root3child1" ) )
    root3.add_child( NicInfo::DataNode.new( "second child of third root", "handle:root3child2", "http:root3child2", "data:root3child2" ) )

    tree.add_root( root1 )
    tree.add_root( root2 )
    tree.add_root( root3 )

    expect( tree.find_data( "1=" ) ).to eq( "data:root1" )
    expect( tree.find_handle( "1=" ) ).to eq( "handle:root1" )
    expect( tree.find_rest_ref( "1=" ) ).to eq( "http:root1" )

    expect( tree.find_data( "1.1=" ) ).to eq( "data:root1child1" )
    expect( tree.find_handle( "1.1=" ) ).to eq( "handle:root1child1" )
    expect( tree.find_rest_ref( "1.1=" ) ).to eq( "http:root1child1" )

    expect( tree.find_data( "1=2=" ) ).to eq( "data:root1child2" )
    expect( tree.find_handle( "1=2=" ) ).to eq( "handle:root1child2" )
    expect( tree.find_rest_ref( "1=2=" ) ).to eq( "http:root1child2" )

    expect( tree.find_data( "2=" ) ).to eq( "data:root2" )
    expect( tree.find_handle( "2=" ) ).to eq( "handle:root2" )
    expect( tree.find_rest_ref( "2=" ) ).to eq( "http:root2" )

    expect( tree.find_data( "2.1=" ) ).to eq( "data:root2child1" )
    expect( tree.find_handle( "2.1=" ) ).to eq( "handle:root2child1" )
    expect( tree.find_rest_ref( "2.1=" ) ).to eq( "http:root2child1" )

    expect( tree.find_data( "2.4=" ) ).to eq( "data:root2child4" )
    expect( tree.find_handle( "2.4=" ) ).to eq( "handle:root2child4" )
    expect( tree.find_rest_ref( "2.4=" ) ).to eq( "http:root2child4" )

    expect( tree.find_data( "2.4=1=" ) ).to eq( "data:root2child4child1" )
    expect( tree.find_handle( "2.4=1=" ) ).to eq( "handle:root2child4child1" )
    expect( tree.find_rest_ref( "2.4=1=" ) ).to eq( "http:root2child4child1" )

    expect( tree.find_data( "2.4=2=" ) ).to eq( "data:root2child4child2" )
    expect( tree.find_handle( "2.4=2=" ) ).to eq( "handle:root2child4child2" )
    expect( tree.find_rest_ref( "2.4=2=" ) ).to eq( "http:root2child4child2" )

    expect( tree.find_data( "2.4.3=" ) ).to eq( "data:root2child4child3" )
    expect( tree.find_handle( "2.4.3=" ) ).to eq( "handle:root2child4child3" )
    expect( tree.find_rest_ref( "2.4.3=" ) ).to eq( "http:root2child4child3" )

    expect( tree.find_data( "3=" ) ).to eq( "data:root3" )
    expect( tree.find_handle( "3=" ) ).to eq( "handle:root3" )
    expect( tree.find_rest_ref( "3=" ) ).to eq( "http:root3" )

    expect( tree.find_data( "3.1=" ) ).to eq( "data:root3child1" )
    expect( tree.find_handle( "3.1=" ) ).to eq( "handle:root3child1" )
    expect( tree.find_rest_ref( "3.1=" ) ).to eq( "http:root3child1" )

    expect( tree.find_data( "3.2=" ) ).to eq( "data:root3child2" )
    expect( tree.find_handle( "3.2=" ) ).to eq( "handle:root3child2" )
    expect( tree.find_rest_ref( "3.2=" ) ).to eq( "http:root3child2" )

  end

end
