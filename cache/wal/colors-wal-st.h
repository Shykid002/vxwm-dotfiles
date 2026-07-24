const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0b0404", /* black   */
  [1] = "#474747", /* red     */
  [2] = "#575757", /* green   */
  [3] = "#6F6F6F", /* yellow  */
  [4] = "#8F8F8F", /* blue    */
  [5] = "#AEAEAE", /* magenta */
  [6] = "#CECECE", /* cyan    */
  [7] = "#c2c0c0", /* white   */

  /* 8 bright colors */
  [8]  = "#665454",  /* black   */
  [9]  = "#474747",  /* red     */
  [10] = "#575757", /* green   */
  [11] = "#6F6F6F", /* yellow  */
  [12] = "#8F8F8F", /* blue    */
  [13] = "#AEAEAE", /* magenta */
  [14] = "#CECECE", /* cyan    */
  [15] = "#c2c0c0", /* white   */

  /* special colors */
  [256] = "#0b0404", /* background */
  [257] = "#c2c0c0", /* foreground */
  [258] = "#c2c0c0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
