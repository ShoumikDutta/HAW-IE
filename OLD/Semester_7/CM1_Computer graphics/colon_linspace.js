/*
 * colon generates vector of equidistant elements
 * @param{Number} start first element of generated vector
 * @param{Number} end last element of generated vector
 * @param{Number} incr (optional) increment between elements
 * @param{Array} the generated array
*/
function colon(start, end, incr) {
    if(incr===undefined) {
       incr = 1;
    }
    var N = Math.floor((end-start)/incr) + 1;
    var result = new Array(N);
    result[0] = start;
    for(var k = 1; k<N; ++k) {
       result[k] = result[k-1] + incr;
    }
    return result;
}



/*
 * linspace generates vector of equidistant elements
 * @param{Number} start first element of generated vector
 * @param{Number} end last element of generated vector
 * @param{Number} N (optional) number of generated elements (default 100)
 * @param{Array} the generated array
*/
function linspace(start, end, N) {
    if(N===undefined) {
        N = 100;
    }

    var result = new Array(N);
    result[0] = start;
    var incr = (end-start)/(N-1);
    for(var k = 1; k<N; ++k) {
       result[k] = result[k-1] + incr;
    }
    return result;
}