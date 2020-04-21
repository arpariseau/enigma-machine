# engima-machine

## Functionality

- This machine is currently capable of encrypting, decrypting, and cracking an
encryption, including taking into account and displaying alternate keys that
provide the exact same encryption because of how the encryption method works. It
 is fully usable through the command-line interface and associated runner files.

## Object-Oriented Programming

- The structure includes three classes that handle the encrypting, decrypting
and cracking - "Cipher", "Enigma" and "Bombe", as well as three classes that
handle the command line interface - "Encryption", "Decryption", and "Code
Cracker" for each of the three functionalities. Also included, for the sake of
making things simple for the command line interface classes, are two modules,
"Readable" and "Writable", which handle reading files and writing files,
respectively, across all three classes. The "Enigma" class handles encrypting
and decrypting, as well as checking if the cracked settings from the "Bombe" are
 correct. Enigma does not have methods to encode anything itself - it just sets
up everything to be encoded. That responsibility falls into the "Cipher" class,
which creates the ciphers and actually encodes the message before getting
reassembled into a fully encrypted message by Enigma and vice versa. That said,
because Enigma is a type of enciphering machine, I felt it was appropriate to
make it a child of the Cipher class. That usefulness is limited in the scope of
this project, but were we to make more ciphers, it would make more sense. The
"Bombe" class may not make sense at first, but it's so named for the machines
that would calculate the settings for Enigma by using "cribs", common words
expected to be in messages. And that's exactly what the Bombe class does here -
it takes the " end" crib and uses that to calculate the settings for the Enigma
class. It then uses the Enigma classes' decrypt method to check its work - just
as the cryptographers at Bletchley Park would use a captured Enigma machine to
then work out the actual messages after they figured out the settings.

## Ruby Conventions & Mechanics

- Reasoning behind the naming of the "Cipher", "Enigma" and "Bombe" classes has
already been provided. The "Encryption", "Decryption" and "Code Cracker" classes
 handle all the CLI and file I/O for encrypting, decrypting and cracking
respectively, and allow their matching runner files to be 3 or 4 lines long
depending on whether or not you count the "requires" lines. Every method was
written to be under 10 lines, and a variety of enumerables have been used. I
won't claim they're all perfect, but I feel like they all have their proper
purpose. As for datatypes both arrays and hashes are used as needed, and
iterated over properly.

## Test-Driven Development

- Every method that does not relate to CLI or I/O has been tested - I tried to
figure out how to use stubs to best simulate that, but decided that additional
effort trying to figure it out was best spent elsewhere. Stubs are used when
testing the date and when randomly generating a key, allowing them to be
consistent. Testing may have not exhausted every possibility, but I took the
liberty of trying to test as many edge case scenarios as possible - for example,
 when testing the encoding method, I used the phrase "Duck?" so that it would
test both handling capital letters as well as symbols that were not going to be
encrypted. That one test not only checks functionality, but takes care of both
edge cases at once. All tests check the method without worrying about the
functionality of methods for other classes. Tests were almost always written
first - the only exceptions being the occasional refactor where an already
existing method was broken into components - the components were not rewritten,
but tests were added to make sure the new submethods were doing exactly what
they were supposed to be doing. Coverage is not quite at 100%, but that's
largely due to the methods that I could not figure out how to test involving
either CLI or I/O. Once accounted for, the rest is at 100%.

## Version Control

- I'm well above both the commits and pull request requirements. The pull
requests were made for the cipher class, the encrypt method (two, reopening the
branch and making a second after I realized that I hadn't done the variants that
 had today's date and a randomly generated code), the CLI for doing the encrypt,
 the decrypt method, the CLI for doing the decrypt, the crack method, the Bombe
class, and the CLI for doing the crack. Not all of them are perfect - for
example, while doing the decrypt CLI, I realized I had made a mistake in the
encrypt CLI, and so adjusted that while still on the decrypt CLI match, but they
 were at the very least all related. Similarly, not every commit was perfect,
but they were made regularly at each test-method pair, save occasionally
bringing over things together in a refactor when they happened to have related
functionality. Tried to keep imperative mood in commit messages once I got the
feedback to use it more after the independent challenge, and made sure to be
explicit about the point of the commit. Maybe not perfectly pristine, but I feel
 still well within the realm of best practice.
