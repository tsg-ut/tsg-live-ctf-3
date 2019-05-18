#!/bin/sh

DUMMY="              + +  *        +     * +   .      + +  *     +     * * +   .        + +  *        +     * * +   .       + +  *     +     * * +   .         + +  *      +     *     * +   .        + +  *          +     * * +   .            + +  *         +     *     * +   .       + +  *        +     * * +   .        + +  *        +     * * +   .      + +  *     +     *     * +   .        + +  *      +     *     * +   .         + +  *         +     * * +   .        + +  *      +     *     * +   .        + +  *      +     *     * +   .         + +  *         +     * * +   .      + +  *      +     *     * +   .      + +  *      +     * * +   .       + +  *      +     *     * +   .         + +  *      +     *     * +   .       + +  *         +     * * +   .     + +  *     +     * * +   .        + +  *        +     *     * +   .       + +  *     +     *     * +   ."

REAL="              + +  *        +     * +   .      + +  *     +     * * +   .        + +  *        +     * * +   .       + +  *     +     * * +   .         + +  *      +     *     * +   .        + +  *          +     * * +   .            + +  *         +     *     * +   .        + +  *           +     * * +   .      + +  *       +     *     * +   .     + +  *     +     * * +   .       + +  *     +     * * +   .            + +  *                   +     * * +   .        + +  *        +     * * +   .            + +  *        +     *     * +   .         + +  *         +     *     * +   .      + +  *       +     * * +   .        + +  *         +     *     * +   .        + +  *         +     * * +   .             + +  *          +     * * +   .             + +  *              +     *     * +   .        + +  *      +     *     * +   .              + +  *       +     * * +   .           + +  *     +     *     * +   .      + +  *     +     *     * +   .        + +  *     +     *     * +   .        + +  *     +     * * +   .      + +  *       +     * * +   .         + +  *           +     * * +   .        + +  *        +     * * +   .              + +  *        +     *     * +   .        + +  *        +     * * +   .      + +  *       +     * * +   .        + +  *     +     *     * +   .             + +  *                   +     * * +   .          + +  *             +     *     * +   .        + +  *       +     *     * +   .       + +  *         +     *     * +   .         + +  *        +     * * +   .       + +  *         +     *     * +   .        + +  *     +     *     * +   .           + +  *       +     * * +   .        + +  *        +     * * +   .             + +  *      +     *     * +   .        + +  *         +     *     * +   .        + +  *      +     * * +   .             + +  *         +     * * +   .              + +  *        +     *     * +   .        + +  *        +     * * +   .      + +  *       +     * * +   .        + +  *     +     *     * +   .             + +  *                   +     * * +   .            + +  *          +     *     * +   .         + +  *      +     * * +   .      + +  *      +     *     * +   .       + +  *       +     * * +   .         + +  *        +     * * +   .             + +  *                     +     *     * +   .     + +  *     +     * * +   .     + +  *     +     * * +   .      + +  *     +     * * +   ."

cat starry.go | sed "s/FLAG_CODE_AREA/$DUMMY/g" > ../problem/starry.go
cat starry.go | sed "s/FLAG_CODE_AREA/$REAL/g" > ../writeup/starry.go
