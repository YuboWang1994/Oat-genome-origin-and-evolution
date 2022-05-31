#!/usr/bin/env python

import sys
import argparse
from Bio import SeqIO
#from string import maketrans


def seqNumber(seq, length):

    seqNew = ''
    number = 0
    for base in seq:
        number += 1
        try:
            seqNew += base
        except TypeError:
            print(base)
            print(seq)
        if number%length == 0:
            seqNew += '\n'
    return seqNew


def main(args):

    seqData = SeqIO.to_dict(SeqIO.parse(open(args.fasta, 'r'), "fasta"))

    if args.change:
        strOld = ''.join(args.old)
        strNew = ''.join(args.new)
        table = str.maketrans(strOld, strNew)

    resultOut = ''
    if args.id:
        f = open(args.id, 'r')
        ids = f.read().strip().split('\n')
        f.close()
    else:
        ids = seqData.keys()
    for seqId in ids:
        resultOut += '>' + seqData[seqId].description + '\n'
        seq = str(seqData[seqId].seq).replace('\n', '')
        if args.change:
            seqChange=seq.translate(table)
        else:
            seqChange = seq
        if args.delete:
            if args.delete == '0':
                seqReplace = seqChange.replace(' ', '')
            else:
                seqReplace = seqChange.replace(args.delete, '')
        else:
            seqReplace = seqChange
        seqNew = seqNumber(seqReplace, args.base)
        resultOut += seqNew + '\n'

    with open(args.result, 'w') as f:
        f.write(resultOut)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description = "Replace U by X or remove blank in sequences.Edit by:TY")
    parser.add_argument('-f', '--fasta', metavar = 'file', required=True, help='File with fasta format need to change.')
    parser.add_argument('-i', '--id', metavar = 'file', help='Ids order in output if you define this options.')
    parser.add_argument('-c', '--change', action = 'store_true', default = False, help = 'Change A to B in sequnences.\
        Only when set [-c/--change], [-o/--old] and [-n/--new] can make sense and these two parameters must be paired.')
    parser.add_argument('-o', '--old', metavar = 'string', nargs = '+', help='Strings need to change: U # etc. \
        You can input several string seperated by white space: U T ...')
    parser.add_argument('-n', '--new', metavar = 'string', nargs = '+', help='Stings that will change to: X etc.\
        You can input several string seperated by white space: X U ... Strings in [-n/--new] must correspond to strings in [-o/--old].')
    parser.add_argument('-d', '--delete', metavar = 'string', help='Remove string in sequences. Input 0 for white blank.')
    parser.add_argument('-b', '--base', metavar = 'int', type = int, default = 100, help = 'Define the number of bases per line. Default: 100.')
    parser.add_argument('-r', '--result', metavar = 'file', default = 'change.fa', help='File of result. Default: change.fa')

    args = parser.parse_args()
    #print >> sys.stderr, args

    main(args)
